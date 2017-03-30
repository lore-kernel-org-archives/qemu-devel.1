Received: from eggs.gnu.org ([2001:4830:134:3::10]:56469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctfFF-0001uY-Ky
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctfFE-00067g-PL
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:56:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-5-git-send-email-armbru@redhat.com>
	<21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com>
Date: Thu, 30 Mar 2017 20:56:18 +0200
In-Reply-To: <21a9cc9f-03f4-382f-2816-b0c40c9c267a@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 13:00:55 -0500")
Message-ID: <87r31ewq3x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 4/9] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/30/2017 12:43 PM, Markus Armbruster wrote:
>> -blockdev and blockdev_add convert their arguments via QObject to
>> BlockdevOptions for qmp_blockdev_add(), which converts them back to
>> QObject, then to a flattened QDict.  The QDict's members are typed
>> according to the QAPI schema.
>> 
>> -drive converts its argument via QemuOpts to a (flat) QDict.  This
>> QDict's members are all QString.
>> 
>> Thus, the QType of a flat QDict member depends on whether it comes
>> from -drive or -blockdev/blockdev_add, except when the QAPI type maps
>> to QString, which is the case for 'str' and enumeration types.
>> 
>
>> +++ b/block/file-posix.c
>> @@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
>>      int ret;
>>  
>>  #if defined(__APPLE__) && defined(__MACH__)
>> +    /*
>> +     * Caution: while qdict_get_try_str() is fine, getting non-string
>> +     * types would require more care.  When @options come from -blockdev
>> +     * or blockdev_add, its members are typed according to the QAPI
>> +     * schema, but when they come from -drive, they're all QString.
>> +     */
>>      const char *filename = qdict_get_str(options, "filename");
>
> Comment mentions (via copy-and-past) qdict_get_try_str(), but this
> instance uses qdict_get_str().  Doesn't bother me enough to withhold
> review if you leave it, though.
>
>
>> +++ b/block/nfs.c
>> @@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
>>          goto out;
>>      }
>>  
>> +    /*
>> +     * Caution: this works only because all scalar members of
>> +     * NFSServer are QString in @crumpled_addr.  The visitor expects
>> +     * @crumpled_addr to be typed according to the QAPI scherma.  It
>
> s/scherma/schema/

In case nothing else comes up, I hope both can be touched up on commit.
Max?

>> +     * is when @options come from -blockdev or blockdev_add.  But when
>> +     * they come from -drive, they're all QString.
>> +     */
>
> With the typo fix,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
