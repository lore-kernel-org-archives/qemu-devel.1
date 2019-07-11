Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5AC742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3223C20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nogCuAtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3223C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqbq-0003Fu-RN
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hlqbb-0002eX-Qy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hlqba-0004og-Io
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hlqba-0004nk-BL; Fri, 12 Jul 2019 04:08:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so7996888wms.2;
 Fri, 12 Jul 2019 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WCJ1WAVZEM3GFUgh4ZmLlXot2lY9cz/AmFZybQqs0BM=;
 b=nogCuAtCBKMhAxZAbqeqPCmjtcD3AqE5hW1LSwj91FulAdHAa+9Mz+CEn1VBPiCO0A
 C8iLLAiYJX6MXnUkxtV+3XnvtPBg5u0P1I6OEeMv93R/LDMAh870PmdVNqk+zNUhtBrZ
 x1HcnYltVck01Va5siMFltFIZD/6wg1GDXlvVqvuMThYDgSyG6tGk65z+eLqsWlh2JlH
 FE4++rfkvSm6g6NUdsp/9J7praoZSpOXxxfjbAdJv+82bNZI93A9BiB0Q2Fg+jv5gffO
 leqW4VOSXRIPDOlM789XY1IlOjQMo1dJdAqlORCyBJklrTbic4euf4sVpO3kTOC5LCHc
 +nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WCJ1WAVZEM3GFUgh4ZmLlXot2lY9cz/AmFZybQqs0BM=;
 b=kil5xtobT1pftBaiTOuqWO6/Vrri86kCBgAg3Rr7y7zWLEyeopL6fASeLlN7famc8n
 FJYGbQtk7H06yqfvmroa8GYAJnrebOCFSi5bBRqxWlqoblSHT6cajkJ9vDP+2INHZOn3
 ZeqVd8HuWggmjgE1hBwzeCjoVCOx3Dgg5cevPBAXNOdvpLIW1wNBlX+7R7X2NYNm61Gb
 5+QpNAe2dxfXopMQf1AkbjXJ0TM+oqZvNJp/60OytWLN6W+aY/N8vQvDBaw48uqZkR6Y
 0EsdU95aAFjiOc1BxzOdKI5LOnQNH1+nAEwei88741MYudeCLN96XMdHeaicTc0xt+xS
 oOYA==
X-Gm-Message-State: APjAAAWerQ+pYHN20h4WNB/7KeAPme8eejjlaFBF/plZGK2aXOE5EHkT
 e8bv68T88fovVPv/U2Beits=
X-Google-Smtp-Source: APXvYqxQyPc6hv05eEjs1eFbtHf+RSFZQrWc0BUClE5p+yDLcvNXTxuZkldjosDMTz+7co7xCDa+AA==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr5492576wme.95.1562918912872; 
 Fri, 12 Jul 2019 01:08:32 -0700 (PDT)
Received: from localhost ([92.184.96.85])
 by smtp.gmail.com with ESMTPSA id h14sm7829907wrs.66.2019.07.12.01.08.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 01:08:32 -0700 (PDT)
Date: Thu, 11 Jul 2019 12:31:20 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190711103120.GF13422@stefanha-x1.localdomain>
References: <20190704124342.7753-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <20190704124342.7753-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/1] Don't obey the kernel
 block device max transfer len / max segments for raw block devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 03:43:41PM +0300, Maxim Levitsky wrote:
> Linux block devices, even in O_DIRECT mode don't have any user visible
> limit on transfer size / number of segments, which underlying kernel bloc=
k device can have.
> The kernel block layer takes care of enforcing these limits by splitting =
the bios.
>=20
> By limiting the transfer sizes, we force qemu to do the splitting itself =
which
> introduces various overheads.
> It is especially visible in nbd server, where the low max transfer size o=
f the
> underlying device forces us to advertise this over NBD, thus increasing t=
he
> traffic overhead in case of image conversion which benefits from large bl=
ocks.
>=20
> More information can be found here:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1647104
>=20
> Tested this with qemu-img convert over nbd and natively and to my surpris=
e,
> even native IO performance improved a bit.
>=20
> (The device on which it was tested is Intel Optane DC P4800X,
> which has 128k max transfer size reported by the kernel)
>=20
> The benchmark:
>=20
> Images were created using:
>=20
> Sparse image:  qemu-img create -f qcow2 /dev/nvme0n1p3 1G / 10G / 100G
> Allocated image: qemu-img create -f qcow2 /dev/nvme0n1p3 -o preallocation=
=3Dmetadata  1G / 10G / 100G
>=20
> The test was:
>=20
>  echo "convert native:"
>  rm -rf /dev/shm/disk.img
>  time qemu-img convert -p -f qcow2 -O raw -T none $FILE /dev/shm/disk.img=
 > /dev/zero
>=20
>  echo "convert via nbd:"
>  qemu-nbd -k /tmp/nbd.sock -v  -f qcow2 $FILE -x export --cache=3Dnone --=
aio=3Dnative --fork
>  rm -rf /dev/shm/disk.img
>  time qemu-img convert -p -f raw -O raw nbd:unix:/tmp/nbd.sock:exportname=
=3Dexport /dev/shm/disk.img > /dev/zero
>=20
> The results:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1G sparse image:
>  native:
> 	before: 0.027s
> 	after: 0.027s
>  nbd:
> 	before: 0.287s
> 	after: 0.035s
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 100G sparse image:
>  native:
> 	before: 0.028s
> 	after: 0.028s
>  nbd:
> 	before: 23.796s
> 	after: 0.109s
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1G preallocated image:
>  native:
>        before: 0.454s
>        after: 0.427s
>  nbd:
>        before: 0.649s
>        after: 0.546s
>=20
> The block limits of max transfer size/max segment size are retained
> for the SCSI passthrough because in this case the kernel passes the users=
pace request
> directly to the kernel scsi driver, bypassing the block layer, and thus t=
here is no code to split
> such requests.
>=20
> Fam, since you was the original author of the code that added
> these limits, could you share your opinion on that?
> What was the reason besides SCSI passthrough?
>=20
> V2:
>=20
> *  Manually tested to not break the scsi passthrough with a nested VM
> *  As Eric suggested, refactored the area around the fstat.
> *  Spelling/grammar fixes
>=20
> Best regards,
> 	Maxim Levitsky
>=20
> Maxim Levitsky (1):
>   raw-posix.c - use max transfer length / max segement count only for
>     SCSI passthrough
>=20
>  block/file-posix.c | 54 ++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
>=20
> --=20
> 2.17.2
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0nD/gACgkQnKSrs4Gr
c8jOLAgAn9iXqFTe/BNyOQJ2nmFVw6o5yoiLC1vFW+W4D0FDKWHATYR5+f7TFTxL
sUOC3NJ5hPfutvJsuU7bMHiw4VA3uIS73hL9HrVyBnIj6cfq8z7TAwOdVuGC4M4L
2sIoY3VusdDI5hsOy28r96D/h5kVvqSHCzXZTBJ13faBTZ1bBzkIaJtBhM1/Jrjm
SjWIAJ9rScGrmGw+8e5vcApbPlxDaSyeUCADZMXL95U5ZncCr/tj223CXJ5hwfkU
UTpGgCpPjUXbQG5xoLFOuBz5pVnWYWPTYiz6Eo3MPB2IOc7CPK+czyRcSvQcta75
GTbT8CXkT6pI5B1VOvWcNH/6/f4VDQ==
=uDIK
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--

