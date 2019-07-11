Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB8C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17B520863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMzqJa1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17B520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqc2-000460-Rh
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hlqbe-0002ib-TJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hlqbd-0004re-QA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hlqbd-0004qK-JA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:08:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so8929134wrl.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oUyvG8ADCkc+zDBWJNSf/kJzw7uQYjwcsWjp0+Lpe0c=;
 b=dMzqJa1ivacnHs06eswckqgPPL2Gh3qiGB6+NI63idrPnxEOgiYZmjMhGfdwhyxsQp
 VojOYwTB4Oy8r2HfNH+Y78JPtnBnHxK3gxTrJy4ID37zrYSVCYwCB8eYspvJAGvPUcDM
 h2n93R+XN84WyiVJjxwIqw1OmXgwkCh8P5tdbDWZzcvh5RKUN+nFerKErJXEqYg6HLvU
 0h7WnYEmvX7ZLYZ7e1czYMVtBmL0A0FeW5ovxNTcTSXtGqybOHyDxT91wLIAv2gKGSL1
 GBklq81fw2YeJKNB6nQKTnk5NUqTu+/3ra23y1yshkFRxl+1qDMn6Q7ZvlyVcohat0Ij
 v4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oUyvG8ADCkc+zDBWJNSf/kJzw7uQYjwcsWjp0+Lpe0c=;
 b=DW/CZDNTnwyIvE1Cs6eHo3stITb02f+aTQ2R7Z5r5qM2ZDX9w+k6mqCPx0qbEQv4KA
 1Yq2Ypt5PeUhx3wVc/wnjU0dDb3GCPvb3HLt4raMim0waZElKD9XcIxosqq1Xe6MvzBA
 pJDmPEuvrvxoXisJR0MfNRr1+us8SpBGOE/bR7o5C2GC2usTdUzaCnNeU7tR0cUYoXuZ
 BomM/W2YSUt0hDaQkiCmSbbuQC2D5XO9xGAXE32gtzzD5V7IZqJqK+8WznL3409R4zSZ
 h8zyCHfEb169QHThmGnhtjJgzMx8/1/r3obwDjdpKiMEK0dA4FSX5mv4NwZXbyUyjAMR
 TayQ==
X-Gm-Message-State: APjAAAUMePuDDOhYo/6/6AMlcUoAXFoYW5uALDFhLJYJThhxJw/63aej
 8Y4Qcna8saz2HBnbdnoRosQ=
X-Google-Smtp-Source: APXvYqztYEiN2C5zLge3Mqr1vmMs30pLn23t8+ZLN8JQmNbhHLLJIsDWo0j29Yg9y3Ufu40ZBBvOXQ==
X-Received: by 2002:adf:afe2:: with SMTP id y34mr9857679wrd.250.1562918916484; 
 Fri, 12 Jul 2019 01:08:36 -0700 (PDT)
Received: from localhost ([92.184.96.85])
 by smtp.gmail.com with ESMTPSA id c12sm12075597wrd.21.2019.07.12.01.08.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 01:08:35 -0700 (PDT)
Date: Thu, 11 Jul 2019 12:37:12 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190711103712.GG13422@stefanha-x1.localdomain>
References: <20190705154154.9305-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <20190705154154.9305-1-berrange@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3] doc: document that the monitor console
 is a privileged control interface
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org,
 P J P <ppandit@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2019 at 04:41:54PM +0100, Daniel P. Berrang=E9 wrote:
> A supposed exploit of QEMU was recently announced as CVE-2019-12928
> claiming that the monitor console was insecure because the "migrate"
> command enabled arbitrary command execution for a remote attacker.
>=20
> To be a security risk the user launching QEMU must have configured
> the monitor in a way that allows for other users to access it. The
> exploit report quoted use of the "tcp" character device backend for
> QMP.
>=20
> This would indeed allow any network user to connect to QEMU and
> execute arbitrary commands, however, this is not a flaw in QEMU.
> It is the normal expected behaviour of the monitor console and the
> commands it supports. Given a monitor connection, there are many
> ways to access host file system content besides the migrate command.
>=20
> The reality is that the monitor console (whether QMP or HMP) is
> considered a privileged interface to QEMU and as such must only
> be made available to trusted users. IOW, making it available with
> no authentication over TCP is simply a, very serious, user
> configuration error not a security flaw in QEMU itself.
>=20
> The one thing this bogus security report highlights though is that
> we have not clearly documented the security implications around the
> use of the monitor. Add a few paragraphs of text to the security
> docs explaining why the monitor is a privileged interface and making
> a recommendation to only use the UNIX socket character device backend.
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>=20
> Changed in v3:
>=20
>  - More copy editing from review feedback (Markus, PJP, Alex)
>=20
> Changed in v2:
>=20
>  - Addressed misc typos (Eric / Philippe)
>=20
>  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0nEVgACgkQnKSrs4Gr
c8igBwf/Ul5aXf5cjYdnS9d60PVMjzDPYTkR+Xh2GFfXOfuXqEG03d5EcpdugSQm
n2d9c9dcyjL2D1mtjWSB9V3fjzJyewlXw9MhfQEP0GeEu1jo6TkcuU+dkezxkRIE
6MKbulABm18rm+7PH6nBny+EiLMST2x+DymCJqComjELjVanW30DDiy4Je/SAv97
gMhsUGcT4ZEGYu9k9ydkiwCMT1UJxq/4JdOWDolPy903qcrhhXs6wXQdV0KDfUdw
0Nk5VZJhqMcbB6RUC5+Vt7hjgFnlbOJTG1GfVeRUobaH3Fiqcy9PGTKU+MbKVAaH
Ufj2NdNDF6yBDHWnrTHy7apoToVa7A==
=LAfQ
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

