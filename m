Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euGO8-0000bH-89
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1euGO3-0000KT-8y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:40:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1euGO3-0000J3-3d
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:40:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A386A40267D7
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 11:40:33 +0000 (UTC)
References: <20180308155145.19315-1-pbonzini@redhat.com>
	<20180309092454.GC14854@lemon.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcf0cc7c-159f-1f57-00ce-329bed5dcc37@redhat.com>
Date: Fri, 9 Mar 2018 12:40:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180309092454.GC14854@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi: support NDOB (no data-out buffer)
 for WRITE SAME commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/03/2018 10:24, Fam Zheng wrote:
> The standard says this bit is only allowed when UNMAP is set. Do we wan=
t to
> check it here? I.e.
>=20
>            if (!flags && (req->cmd.buf[1] & 0x1)) {
>                scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
>                return;
>            }

Yeah, I had it like that before but my copy of the standard actually
doesn't say that.  It says:

---
To ensure that subsequent read operations return all zeros in a logical
block, use the WRITE SAME (16) command with the NDOB bit set to one. If
the UNMAP bit is set to one, then the device server may unmap the
logical blocks specified by the WRITE SAME (16) command as described in
4.7.3.4.4.

[...]

A NDOB bit set to zero specifies that the device server shall process
the command using logical block data from the Data-Out Buffer. A NDOB
bit set to one specifies that the device server shall not transfer data
from the Data-Out Buffer and shall process the command as if the
Data-Out Buffer contained user data set to all zeroes.
---

This is sbc4r04, and sbc4r15 (the latest) is more or less the same, with
some complications related because LBPRZ has been recently extended.

Paolo
