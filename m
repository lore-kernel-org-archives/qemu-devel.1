Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557EAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9A120784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkfKvjQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A120784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKcZ-000339-BS
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJKa3-0008P8-VK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJKa2-0000zc-JG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:21:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJKa2-0000yZ-EM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585675297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3kAB3k2l5VvR/jpr6gULdceQfe7TVqQ8zWeRMxvkM4=;
 b=QkfKvjQ0ac1e4acVDWVmHVml+dxUc8CGAS99jAmCR2wA9oXJVmBeJc2YmxCZ/vLri7R4Lp
 fX5l5/VRdgIkFkyG1TrfvR6jV8ZNuJgqORNaA36JoSzU0/yKeb7JDSNVS8utwQTKgsSrI8
 u+bCyaknZmdxclwvxbS74UOMLsSn6ew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-yrLdie8iNyGtYFl_Lod5TQ-1; Tue, 31 Mar 2020 13:21:35 -0400
X-MC-Unique: yrLdie8iNyGtYFl_Lod5TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB2D8010EE;
 Tue, 31 Mar 2020 17:21:34 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 718381001938;
 Tue, 31 Mar 2020 17:21:33 +0000 (UTC)
Subject: Re: [PATCH v3] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200331171606.386801-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <32d8b69d-1641-f200-e86e-062de6c93caf@redhat.com>
Date: Tue, 31 Mar 2020 12:21:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331171606.386801-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 12:16 PM, Daniel P. Berrang=C3=A9 wrote:
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20

> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> +    echo
> +    echo "Support for running the 'configure' script directly from the"
> +    echo "source directory is deprecated. In source dir builds are not"
> +    echo "covered by automated testing and thus may not correctly build"
> +    echo "QEMU. Users are recommended to use a separate build directory:=
"

Our mails crossed. I still think this reads a bit awkwardly; maybe:

s/IN SOURCE DIR BUILDS/BUILDING IN THE SOURCE DIR/
s/In source dir builds/In-tree builds/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


