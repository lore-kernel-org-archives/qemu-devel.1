Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B66C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E1A206E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idFcs2m9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E1A206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZc7E-0006Sm-8Q
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZc5U-00051A-NH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZc5R-0003Ej-QS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604332175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vreaaMaZv5ISkFm0TlHo1DmFY5/2LPzpJZn1TAhdLtw=;
 b=idFcs2m9gOsGtZssQypKCSYhLHHhD4fPE7GKHUgkkQESXIa5zcR/nDm/RJOO6ATTEZJ6zJ
 7BfurhPlDCmK1XAcMcY5h66hOLqxga+1ATZYGu4tBs23cV5VJLxWoPsJ+am9co+DLs/F3d
 A0Trwkj7+vugueXme/dRuvCMtpsF0J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-owbAJjkwOTOb0VT0nzMfXg-1; Mon, 02 Nov 2020 10:49:33 -0500
X-MC-Unique: owbAJjkwOTOb0VT0nzMfXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321271084C8A;
 Mon,  2 Nov 2020 15:49:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C480F7366E;
 Mon,  2 Nov 2020 15:49:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5635C1132BD6; Mon,  2 Nov 2020 16:49:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Subject: Re: [PULL 09/12] qga: add ssh-{add,remove}-authorized-keys
References: <20201027055317.351868-1-michael.roth@amd.com>
 <20201027055317.351868-10-michael.roth@amd.com>
Date: Mon, 02 Nov 2020 16:49:27 +0100
In-Reply-To: <20201027055317.351868-10-michael.roth@amd.com> (Michael Roth's
 message of "Tue, 27 Oct 2020 00:53:14 -0500")
Message-ID: <878sbju5bs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Michal Privoznik <mprivozn@redhat.com>,
 "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael Roth <michael.roth@amd.com> writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Add new commands to add and remove SSH public keys from
> ~/.ssh/authorized_keys.
>
> I took a different approach for testing, including the unit tests right
> with the code. I wanted to overwrite the function to get the user
> details, I couldn't easily do that over QMP. Furthermore, I prefer
> having unit tests very close to the code, and unit files that are domain
> specific (commands-posix is too crowded already). FWIW, that
> coding/testing style is Rust-style (where tests can or should even be
> part of the documentation!).
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1885332
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> *squashed in fix-ups for setting file ownership and use of QAPI
>  conditionals for CONFIG_POSIX instead of stub definitions
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qga/commands-posix-ssh.c | 407 +++++++++++++++++++++++++++++++++++++++
>  qga/meson.build          |  20 +-
>  qga/qapi-schema.json     |  35 ++++
>  3 files changed, 461 insertions(+), 1 deletion(-)
>  create mode 100644 qga/commands-posix-ssh.c
>
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> new file mode 100644
> index 0000000000..a7bc9a1c24
> --- /dev/null
> +++ b/qga/commands-posix-ssh.c
> @@ -0,0 +1,407 @@
> + /*
> +  * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> +  * See the COPYING file in the top-level directory.
> +  */
> +#include "qemu/osdep.h"
> +
> +#include <glib-unix.h>
> +#include <glib/gstdio.h>
> +#include <locale.h>
> +#include <pwd.h>
> +
> +#include "qapi/error.h"
> +#include "qga-qapi-commands.h"
> +
> +#ifdef QGA_BUILD_UNIT_TEST
> +static struct passwd *
> +test_get_passwd_entry(const gchar *user_name, GError **error)
> +{
> +    struct passwd *p;
> +    int ret;
> +
> +    if (!user_name || g_strcmp0(user_name, g_get_user_name())) {
> +        g_set_error(error, G_UNIX_ERROR, 0, "Invalid user name");
> +        return NULL;
> +    }
> +
> +    p =3D g_new0(struct passwd, 1);
> +    p->pw_dir =3D (char *)g_get_home_dir();
> +    p->pw_uid =3D geteuid();
> +    p->pw_gid =3D getegid();
> +
> +    ret =3D g_mkdir_with_parents(p->pw_dir, 0700);
> +    g_assert_cmpint(ret, =3D=3D, 0);

checkpatch ERROR: Use g_assert or g_assert_not_reached

See commit 6e9389563e "checkpatch: Disallow glib asserts in main code"
for rationale.

More below, and in PATCH 10+12.

[...]


