Received: from eggs.gnu.org ([2001:4830:134:3::10]:53151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0XpN-0002uY-UC
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0XpA-0005gN-Ph
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:02:53 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
Date: Thu, 13 Sep 2018 15:01:55 -0500
MIME-Version: 1.0
In-Reply-To: <56133002-7a79-bf6a-8835-fba043638224@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 9/13/18 1:37 PM, Max Reitz wrote:
> On 13.09.18 19:05, Eric Blake wrote:
>> [adding Markus, because of an interesting observation about --image-op=
ts
>> vs. JSON null - search for [1] below]
>>
>> On 9/13/18 8:22 AM, Max Reitz wrote:
>>> On 13.09.18 05:33, lampahome wrote:
>>>> I split data to 3 chunks and save it in 3 independent backing files =
like
>>>> below:
>>>> img.000 <-- img.001 <-- img.002
>>>> img.000 is the backing file of img.001 and 001 is the backing file o=
f
>>>> 002.
>>>> img.000 saves the 1st chunk of data and img.001 saves the 2nd chunk =
of
>>>> data, and img.002 saves the 3rd chunk of data.
>>
>> How have you ensured that these three files are visiting different
>> ranges of guest data?
>=20
> He did say "independent".

True, but I'm curious how they were created in the first place (our=20
simple qemu-io -c 'write ...' is fine for testing, but nothing like=20
knowing the real story)


>>> $ qemu-img create -f qcow2 img.000 3M
>>> $ qemu-img create -f qcow2 -b img.000 img.001
>>> $ qemu-img create -f qcow2 -b img.001 img.002
>>> $ qemu-img create -f qcow2 -b img.002 img.003
>>
>> Missing -F qcow2 in those last three lines (you should always specify
>> the backing format in the qcow2 metadata, otherwise you are setting
>> yourself up for failures because probing is unsafe)
>=20
> Is it really unsafe for non-raw images?

In practice, not a problem for isolated testing. But it DOES interfere=20
with libvirt - libvirt assumes that any image that was not explicitly=20
specified is raw, rather than probing it, and treating img.002 as raw=20
(with no access to img.000 or img.001) means reading through img.003=20
sees garbage.

>=20
>>> $ qemu-io -c 'write -P 1 0M 1M' img.000
>>> $ qemu-io -c 'write -P 2 1M 1M' img.001
>>> $ qemu-io -c 'write -P 3 2M 1M' img.002
>>> $ qemu-io -c 'write -P 4 0M 1M' img.003
>>
>> I'd modify this example to use:
>>  =C2=A0qemu-io -c 'write -P 4 0M 512k' -c 'write -P 4 1m 512k' \
>>  =C2=A0=C2=A0 -c 'write -P 4 2m 512k' img.003
>>
>> so that it becomes easier to see if we are ever committing more than
>> desired.
>=20
> Well, I interpreted the problem in a way that .003 does not shadow any
> data from .001 or .002.

True, but the question is again - how was the actual img.003 created, to=20
either ensure that it really does just touch clusters shadowed from .000=20
(qemu-img map output helps, if it's not too verbose).


>> $ qemu-io -c 'discard 0 1m' --image-opts
>> driver=3Dqcow2,backing=3D,file.driver=3Dfile,file.filename=3Dimg.003
>> warning: Use of "backing": "" is deprecated; use "backing": null inste=
ad
>> discard 1048576/1048576 bytes at offset 0
>> 1 MiB, 1 ops; 0.0002 sec (4.399 GiB/sec and 4504.5045 ops/sec)
>>
>> doesn't work, as 'discard' causes img.003 to now make things read as
>> zero rather than deferring to the backing chain,
>=20
> Which is intentional because making data re-appear from the backing
> chain can be a security issue, as far as I remember.

It can be a potential issue if there is a backing file (exposing data=20
that you thought was wiped is not fun).  But where there is NO backing=20
file, it's overly cautious, and gets in our way (we read all zeros from=20
a file with no backing, whether the cluster is marked as 0 or as=20
defer-to-backing).  I'm okay if we still keep the overly cautious way by=20
default, but having a knob to say "discard this, and I really do mean=20
discard rather than read back as 0" would be useful in qemu (after all,=20
that's what fallocate(FALLOC_FL_NO_HIDE_STALE) has recently been used=20
for in the kernel, as the knob for whether discarding on a block device=20
must read back as zero or may go faster [2]).

[2] https://lore.kernel.org/patchwork/patch/953421/

>>
>> $ qemu-io -c 'discard 0 1m' --image-opts '{"driver":"qcow2",
>> "backing":null, "file":{"driver":"file", "filename":"img.003"}}'
>>
>> except THAT doesn't work yet (we haven't converted all our command lin=
e
>> arguments to taking JSON yet). (end [1])
>=20
> I hate json:{}, but we have it, so why not use it?
>=20
> $ qemu-io -c 'discard 0 1m' \
>      "json:{'driver':'qcow2','backing':null,
>             'file':{'driver':'file','filename':'img.003'}}"

Hmm - that's the pseudo-JSON protocol rather than --image-opts detecting=20
a first character of '{'. But yeah, that works for getting at=20
"backing":null cleaner than the "backing=3D" with intentionally empty=20
argument via dotted syntax.


>> Sorry - for all my experimenting, I could NOT find a reliable way to
>> remove duplicated clusters out of img.003 once they were committed to
>> img.000,
>=20
> I'm not sure whether your experiments really concern what the reporter
> needs in his exact case, but just for fun:

Indeed - lampahome, concrete tests with accurate reproduction=20
instructions always makes life easier for people trying to help you.

>=20
> Basically, there is only one way to reliably make an image pass through
> data from its backing files again.  Well, two, actually.  One is
> qemu-img commit, which (for compatibility, mainly) makes the image empt=
y
> after the commit.

And only if you did NOT use the -b option (in other words, it only=20
empties the file if you are committing to the immediate backing file,=20
not deep in the chain).

>  The other is just throwing the image away and
> re-creating it from scratch.

Well yeah, there's that. But now you have a transient problem of extra=20
pressure on your storage, while you have duplicated blocks between old=20
and new images, prior to being able to remove the old image.  If the=20
goal is to make img.000 not grow during the commit, I was assuming that=20
we are already storage-constrained, and any solution that does in-place=20
modification is therefore better than one that has to create yet another=20
copy of data, even if the end result is the same once all operations=20
have finished.

>=20
> So in any case, you cannot reliably do that for just a part of the imag=
e.
>=20
> First, split .003 into the part we want to commit and the part we don't
> want to commit.  This is a bit tricky without qemu-img dd @seek (or a
> corresponding convert parameter), so we'll have to make do with
> backing=3Dnull so we don't copy anything into the output from img.003's
> backing chain.
>=20
> Or, we would have to use backing=3Dnull, but for some reason that doesn=
't
> work.  I'll have to investigate.

Just so I'm following along, what didn't work? 'backing':null in a=20
json:{...} pseudoformat, or driver.raw,file.driver=3Dqcow2,file.backing=3D=
,=20
in dotted syntax?

>=20
> So rebase will need to do:
>=20
> $ qemu-img rebase -u -b '' img.003
>=20
> $ qemu-img convert -O qcow2 \
>      "json:{'driver':'raw','offset':0,'size':1048576,\
>             'file':{'driver':'qcow2',\
>                     'file':{'driver':'file','filename':'img.003'}}}" \
>      "json:{'driver':'null-co','size':2097152}" \
>      img.003.commit.000

Oh right - you can indeed concatenate multiple inputs into one output=20
with qemu-img convert.

>=20
> $ qemu-img convert -O qcow2 \
>      "json:{'driver':'null-co','size':1048576}" \
>      "json:{'driver':'raw','offset':1048576,'size':2097152,\
>             'file':{'driver':'qcow2',\
>                     'file':{'driver':'file','filename':'img.003'}}}" \
>      img.003.nocommit

So you created:

img.000             11----
img.001             --22--
img.002             ----33
img.003             4-4-4-
guest sees          414243
img.003.commit.000  4-----
img.003.nocommit    --4-4-


>=20
> Now let's set the backing files.  img.003.commit.000 has only data that
> goes into img.000, so that goes there, and img.003.nocommit is going to
> replace our old img.003, so that goes where that was:
>=20
> $ qemu-img rebase -u -b img.000 img.003.commit.000
> $ qemu-img rebase -u -b img.002 img.003.nocommit
>=20
> And now let's commit:
>=20
> $ qemu-img commit img.003.commit.000
>=20
> And let's clean up:
>=20
> $ rm img.003.commit.000
> $ mv img.003.nocommit img.003
>=20
> Done.

Done, but with temporary storage usage higher than doing it in place.

>=20
> (If you want to commit all three parts of img.003 into the three
> different base images, you would create img.003.commit.001 and
> img.003.commit.002 similarly as above, and then commit those into the
> respective base images.  Then you'd just rm img.003* and you're back to
> the original state.)

Your solution of qemu-img convert to concatenate null-co with an offset=20
of img.003 is nice.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
