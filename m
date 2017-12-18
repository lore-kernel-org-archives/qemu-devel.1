Received: from eggs.gnu.org ([2001:4830:134:3::10]:58845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eQzYK-0003eU-GP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eQzYA-0006CD-9B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:50:12 -0500
References: <20171128121055.6954-1-den@openvz.org>
	<20171128121055.6954-3-den@openvz.org>
	<c3b6f42e-25b2-205f-b8ad-822321ef0645@redhat.com>
	<7247ee82-c932-58d1-8a79-6af8c3665f0f@openvz.org>
	<ab351bc9-b939-d320-d09d-a5ddb0ff3a73@redhat.com>
	<99ffe289-4e69-f8b6-7722-1bd1620cc5f5@openvz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <805bdd48-fb9c-32b3-63c0-ca2f3ed63faf@redhat.com>
Date: Mon, 18 Dec 2017 12:49:55 -0500
MIME-Version: 1.0
In-Reply-To: <99ffe289-4e69-f8b6-7722-1bd1620cc5f5@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ide: fix crash in IDE cdrom read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 12/14/2017 06:29 AM, Denis V. Lunev wrote:
>> If this has been broken since 2.9, 2.11-rc3 is too late for a bandaid
>> applied to something I can't diagnose. Let's discuss this for 2.12 and=
 I
>> will keep trying to figure out what the root cause is.
> I have read the entire letter in 2 subsequent attempts, but
> unfortunately I can not say much more additionally :(
>=20

No problem, sometimes I don't understand myself. And the IDE code isn't
exactly the nicest stuff to read. If I was smart enough I'd refactor the
whole thing, but without breaking migration it's a little hard :(

>> Some questions for you:
>>
>> (1) Is the guest Linux? Do we know why this one machine might be
>> tripping up QEMU? (Is it running a fuzzer, a weird OS, etc...?)
> This is running by the end-user by our customer and we do not have
> access to that machine and customer. This is anonymized crash report
> from the node. This is not a single crash. We observe 1-2 reports with
> this crash in a day.
>=20

Yikes. Is this still on a 2.9-based VM, or have you upgraded to 2.10 or
2.11 at this point?

(From memory this was a problem with a 2.9 based machine)

>> (2) Does the VM actually have a CDROM inserted at some point? Is it
>> possible we're racing on some kind of eject or graph manipulation fail=
ure?
> unclear but IMHO probable.
>=20

If they're using a 2.10+ based VM, could you look at some trace points?

either:
trace_ide_atapi_cmd (just scsi byte 0), or
trace_ide_atapi_cmd_packet (the entire scsi cdb)

and

trace_ide_exec_cmd

the actual command bytes never get saved in the state struct, so it's
hard to tell from traces what commands were being processed, but these
traces help.

>> (3) Is this using AHCI or IDE?
> IDE. This is known 120%. We do not provide ability to enable AHCI
> without manual tweaking.
>=20

At least that helps narrow down the path...

>> If I can't figure it out within a week or so from here I'll just check
>> in the band-aid with some /* FIXME */ comments attached.
> No prob. We are going to ship my band-aid and see to report statistics.
>=20
> Thank you in advance,
> =C2=A0=C2=A0=C2=A0 Den

I'll stage the band-aid with some FIXME comments, and maybe some scary
error_report prints with some information in them. I'll send it to the li=
st.
