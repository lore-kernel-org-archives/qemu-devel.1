Received: from eggs.gnu.org ([2001:4830:134:3::10]:51767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCUMY-0004kc-3G
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCUMW-0007mE-S5
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:46:37 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-3-kwolf@redhat.com>
	<12e95cce-ab82-08e3-b0ae-2307fe94a392@redhat.com>
	<20181015093753.GB10459@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d1bca96-1eae-5fc2-57bb-912bdd90de9e@redhat.com>
Date: Tue, 16 Oct 2018 13:46:26 -0500
MIME-Version: 1.0
In-Reply-To: <20181015093753.GB10459@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/15/18 4:37 AM, Kevin Wolf wrote:
> Am 12.10.2018 um 18:47 hat Eric Blake geschrieben:
>> On 10/12/18 6:55 AM, Kevin Wolf wrote:
>>> If a management application builds the block graph node by node, the
>>> protocol layer doesn't inherit its read-only option from the format
>>> layer any more, so it must be set explicitly.
>>>
>>

>>
>> Bike-shedding: Do we really want to ignore @read-only? Here's the table of 9
>> combinations ('t'rue, 'f'alse, 'o'mitted), with '*' on the rows that must be
>> preserved for back-compat:
>>
>> RO   Auto   effect
>> o    o      *open for write, fail if not possible
>> f    o      *open for write, fail if not possible
>> t    o      *open for read, no conversion to write
>> o    f      open for write, fail if not possible
>> f    f      open for write, fail if not possible
>> t    f      open for read, no conversion to write
>> o    t      attempt write but graceful fall back to read
>> f    t      attempt write but graceful fall back to read
>> t    t      ignore RO flag, attempt write anyway
>>
>> That last row is weird, why not make it an explicit error instead of
>> ignoring the implied difference in semantics between the two?
> 
> You're right that the description allows this. In practice,
> auto-read-only can only make a node go from rw to ro, not the other way
> round.
> 
> So our options are to document the current behaviour (auto-read-only has
> no effect when the image is already read-only) or to make it an error.

Ah, that's different. I was reading it as "auto-read-only true lets you 
write if possible, overriding an explicit readonly request", while you 
are reading it as "auto-read-only true allows graceful fallback to 
read-only, and is thus a no-op if you already requested readonly"

I like yours better, so it's just a matter of coming up with the correct 
documentation wording.

> 
> One thought I had is that for convenience options like -hda (or in fact
> -drive), auto-read-only=on could be the default, and only -blockdev and
> blockdev-add would disable it by default. That would suggest that we
> don't want to make it an error.

Yes, having convenience options set auto-read-only would not be too 
terrible (since those are already magic and designed for short-hand 
human use), as long as the low-level QMP commands don't add the magic 
(explicit control is better at the low levels).

> 
>> Or, another idea: is it worth trying to support a single tri-state member
>> (via an alternative between bool and enum, since the existing code uses a
>> JSON bool):
>>
>> "read-only": false (open for write, fail if not possible)
>> "read-only": true (open read-only, no later switching)
>> "read-only": "auto" (switch as needed; or for initial implementation attempt
>> for write with graceful fallback to read)
>> omitting read-only: same as "read-only":false for back-compat
> 
> If read-only were new, I would probably make it an enum, but adding it
> now isn't very practical. I did actually start with an alternate and it
> just wasn't very nice. One thing I remember is places that directly
> accessed the options QDict, for which you could now have either a bool, a
> string, an int or not present. It becomes a bit too much.

Fair enough. Maybe it's worth a commit message note that we at least 
considered and rejected alternate implementations.

> 
> As read-only is optional, we could make it true/false/absent without
> introducing an alternate and the additional int/string options, but I
> don't like that very much either.

No, that way is not introspectible.  Adding auto-read-only is much 
friendlier.

> 
> 
> While we're talking about the schema, another thing I considered was
> making auto-read-only an option only for the specific drivers that
> support it so introspection could tell the management tool whether the
> functionality is available. However, if we do this, we can't parse it in
> block.c code and use a flag any more, but need to parse it in each
> driver individually. Maybe it would be a better design anyway?

Which drivers do you have in mind? Ones like file-posix, gluster, and 
NBD that actually have a notion of opening either read-write or 
read-only, or others that are read-only no matter what?

I'm still not convinced that a per-driver option is smart, and am 
reasonably happy with you adding it globally.

> 
>>> @@ -1328,6 +1338,11 @@ QemuOptsList bdrv_runtime_opts = {
>>>                .type = QEMU_OPT_BOOL,
>>>                .help = "Node is opened in read-only mode",
>>>            },
>>> +        {
>>> +            .name = BDRV_OPT_AUTO_READ_ONLY,
>>> +            .type = QEMU_OPT_BOOL,
>>> +            .help = "Node can become read-only if opening read-write fails",
>>> +        },
>>
>> If we keep your current approach, is it worth mentioning that
>> auto-read-only true overrides read-only true?
> 
> This help text is never printed anywhere anyway... Maybe we should just
> delete it. What we refer to is the QAPI documentation anyway.

Are you sure it never gets printed, with some of the recent patches 
around trying to improve help output?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
