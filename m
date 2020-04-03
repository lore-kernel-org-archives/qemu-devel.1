Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B1CC2BA16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADE2206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsqQqiV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADE2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMxr-00047s-6N
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKMuK-0000BK-HM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKMuJ-0001Vc-BY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:02:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKMuJ-0001VL-7c
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585922570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzkLCBkkInwp5RE8uz1vR988oWchn1IS/j5wKF+yNqA=;
 b=HsqQqiV7CW6OROiW8jOs06+GabZ6DFRsBC0eAIFLjTVdtyHwaac/+LnzBWwp5MK24cJmwg
 9WIKZLjH6Hjc7wfSTccULwfJtBVnjUV/aAWTTQr3mAV92F/OiY1dfGOWSpbBR/Ock9cV+p
 uMgqqLAL86X/DJf88ggPNp0x0Khc0Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-USyVHWcdMKuxy1HfHRFeGw-1; Fri, 03 Apr 2020 10:02:49 -0400
X-MC-Unique: USyVHWcdMKuxy1HfHRFeGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B431B18A8C83;
 Fri,  3 Apr 2020 14:02:47 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD2D85E000;
 Fri,  3 Apr 2020 14:02:46 +0000 (UTC)
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200403135306.665493-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
Date: Fri, 3 Apr 2020 09:02:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403135306.665493-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liviu Ionescu <ilg@livius.net>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 8:53 AM, Daniel P. Berrang=C3=A9 wrote:
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> Changed in v4:
>    - Adopted Eric's suggested wording

> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS DEPRECATED"
> +    echo
> +    echo "Support for running the 'configure' script directly from the"
> +    echo "source directory is deprecated. In-tree builds are not covered=
"
> +    echo "by automated testing and thus may not correctly build QEMU."
> +    echo "Users are recommended to use a separate build directory:"
> +    echo
> +    echo "  $ mkdir build"
> +    echo "  $ cd build"
> +    echo "  $ ../configure"
> +    echo "  $ make"

Late question, but:

Since this is just a warning, we still manage to complete the=20
./configure run, including whatever generated files it leaves in-tree.=20
Is there any additional step we need to recommend prior to 'mkdir build'=20
that will clean up the in-tree artifacts, so that the user then=20
attempting the VPATH build won't still have a broken build due to the=20
leftovers from the in-tree attempt?  'make distclean', perhaps?

/me starts testing; I'll reply back once it finishes...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


