Received: from eggs.gnu.org ([2001:4830:134:3::10]:43766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGlMl-0006wt-2r
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGlMh-000825-Tt
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:12:15 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGlMh-00081t-NP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:12:11 -0400
Received: by mail-wr0-x244.google.com with SMTP id p4-v6so1985812wrh.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 06:12:11 -0700 (PDT)
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
Date: Thu, 10 May 2018 14:12:09 +0100
Message-ID: <87lgcrvemu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, khaled.jmal@lauterbach.com


Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:

> The previous version:
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D33714
>
> Abdallah Bouassida (3):
>   target/arm: Add "ARM_CP_NO_GDB" as a new bit field for ARMCPRegInfo
>     type
>   target/arm: Add "_S" suffix to the secure version of a sysreg
>   target/arm: Add the XML dynamic generation
>

So I got a fixed up gdb and I was testing the reading of the virtual
counter:

=3D> 0xffffff800854a118 <arch_counter_get_cntvct+16>:	mrs	x0, cntvct_el0
   0xffffff800854a11c <arch_counter_get_cntvct+20>:	b	0xffffff800854a148 <a=
rch_counter_get_cntvct+64>
   0xffffff800854a120 <arch_counter_get_cntvct+24>:	adrp	x0, 0xffffff800896=
a000 <scsi_format_log+3568>
   0xffffff800854a124 <arch_counter_get_cntvct+28>:	add	x0, x0, #0x5a0
   0xffffff800854a128 <erratum_set_next_event_tval_virt+4294964112>:	mrs	x1=
, tpidr_el1

p/x $x0
 $6 =3D 0xffffff800854a108
p/x $cntvct_el0
 $7 =3D 0x0
stepi
0xffffff800854a11c	160		return arch_timer_reg_read_stable(cntvct_el0);
=3D> 0xffffff800854a11c <arch_counter_get_cntvct+20>:	b	0xffffff800854a148 =
<arch_counter_get_cntvct+64>
   0xffffff800854a120 <arch_counter_get_cntvct+24>:	adrp	x0, 0xffffff800896=
a000 <scsi_format_log+3568>
   0xffffff800854a124 <arch_counter_get_cntvct+28>:	add	x0, x0, #0x5a0
p/x $x0
  $8 =3D 0x7a5b32b
p/x $cntvct_el0
  $9 =3D 0x0

So I'm wondering why there is a disparity here?

--
Alex Benn=C3=A9e
