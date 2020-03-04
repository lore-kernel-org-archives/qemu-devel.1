Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB8A20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUTErjiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB8A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QzA-0002ER-Mh
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j9QyS-0001eZ-Bi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j9QyP-0005tI-RL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:09:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j9QyP-0005s5-H8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583316592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3YnEWzefIEP6vPwHwy3+XjapI2lE8/ZRyLbmDrmFj4=;
 b=aUTErjiGNgECHikcuAqNLzOz2e80rsKoUcAisLQS+oCvFChT7UQAGjjr7PG4NC2PmDf8JJ
 /sN8dGretOucyjTpCPZAYU41/cvPKjff1tMGkpNFuIZ1NrYZx4zBjuFcVXhc6wmn6PZizJ
 kFpZh6ZD26fXvAoJ93X/YzHENG1gIa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-AWf4ueL-MGah7GTxbKpNjg-1; Wed, 04 Mar 2020 05:09:48 -0500
X-MC-Unique: AWf4ueL-MGah7GTxbKpNjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9665C107ACC7;
 Wed,  4 Mar 2020 10:09:46 +0000 (UTC)
Received: from work-vm (ovpn-116-225.ams2.redhat.com [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83A791001B3F;
 Wed,  4 Mar 2020 10:09:34 +0000 (UTC)
Date: Wed, 4 Mar 2020 10:09:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 14/50] mutli-process: build remote command line args
Message-ID: <20200304100932.GA4104@work-vm>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jagannathan Raman (jag.raman@oracle.com) wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  v4 -> v5:
>   - Added "exec" suboption to get the executable's name
>   - Addressed feedback about variable names
>   - Removed redundant check for spawning a process
>=20
>  hw/proxy/qemu-proxy.c         | 68 +++++++++++++++++++++++++++++++++----=
------
>  include/hw/proxy/qemu-proxy.h |  2 +-
>  2 files changed, 54 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index 828bbd7..d792e86 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -19,19 +19,50 @@
> =20
>  static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
> =20
> +static int add_argv(char *opts_str, char **argv, int argc)
> +{
> +    int max_args =3D 64;

...

> +
> +static int make_argv(char *opts_str, char **argv, int argc)
> +{
> +    int max_args =3D 64;

.....

> +
>  static int remote_spawn(PCIProxyDev *pdev, const char *opts,
>                          const char *exec_name, Error **errp)
>  {
> -    char *args[3];
>      pid_t rpid;
>      int fd[2] =3D {-1, -1};
>      Error *local_error =3D NULL;
> +    char *argv[64];


Magic '64' in a lot of places; that should be one constant somewhere
(if it's actually needed).

Dave


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


