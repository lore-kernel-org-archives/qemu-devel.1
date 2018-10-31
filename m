Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHote-0002Qt-R9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHota-0002AG-PX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHota-0001ma-AM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:42:46 -0400
References: <1540935767-21467-1-git-send-email-george.kennedy@oracle.com>
	<580389b2-4462-ca99-6f80-752c49f603b6@redhat.com>
	<fb9cafab-8a35-2220-4c60-b74d247bb649@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2afd96c-a7f7-9e7b-d756-997f6ebd3bc8@redhat.com>
Date: Wed, 31 Oct 2018 12:42:23 +0100
MIME-Version: 1.0
In-Reply-To: <fb9cafab-8a35-2220-4c60-b74d247bb649@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] lsi_scsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

On 31/10/2018 12:29, George Kennedy wrote:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 case 2: /* Wait Reselect */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!s->resel_dsp) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->resel_dsp =3D s->dsp - 8=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>
>> What is the reason for the "if"?
>
> The save of the Rselection Script address only needs to be done once

That's not correct.  There could be more than one WAIT RESELECT instructi=
on.

(I'm also not sure why the "- 8", which causes the WAIT RESELECT opcode
to run again.  I think that, instead of that "- 8", you're missing a
call to lsi_wait_reselect where you set s->dsp =3D s->resel_dsp.  It make=
s
sense: after disconnecting from one target, you immediately fake a
reselect from the target.  This isn't quite right, the reselection
should be in lsi_transfer_data, but it's a start).

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lsi_irq_on_rsl(s)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (save_dsp) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->=
dsp =3D save_dsp;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sav=
e_dsp =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsi_wait_resele=
ct(s);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> @@ -1476,6 +1501,10 @@ again:
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (insn & (1 << 28)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D s->dsa + sextract32(addr, 0, 2=
4);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
 else if (s->want_resel && s->resel_dsp && !(insn & (1
>>> << 24))) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 save_dsp =3D s->dsp;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 s->dsp =3D s->resel_dsp;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 s->want_resel =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>> Can you explain why this is placed under the LOAD AND STORE instructio=
n?
>>
>> Your previous patch has, more specifically, a store from the scratch
>> register into memory.=C2=A0 In the Linux scripts this occurs twice, bo=
th
>> after a DISCONNECT instruction.=C2=A0 Is that the place where you want=
 to
>> hook?
>
> Yes. I can revert to what was in the previous patch. I had figured that=
,
> like the change to capture the Reselection Script address, the point
> where the DSP address gets loaded with the Script Reselection address
> could be handled in a similar manner.

There is only one correct way to handle SCRIPTS instructions, and it's
the one that matches the data sheet.  In other words, even if we agree
to an incomplete solution it still must have some foundation in the
datasheet and parallel SCSI spec.  We have to adjust for the coalescing
of initiator/target/scripts that occurs in lsi53c895a.c, but that should
be it.

In particular, the reselection script is captured in WAIT RESELECT
because the data sheet says so:

  If the LSI53C895A is reselected, it fetches the next
  instruction from the address pointed to by the DMA
  SCRIPTS Pointer (DSP) register.

but LOAD AND STORE has nothing to do with reselection.

Paolo
