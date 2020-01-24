Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF3C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496EB2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTeo4zXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496EB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuxII-0000W0-Ed
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuxHl-000054-DW
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuxHh-00088j-3c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:37:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuxHg-000865-PN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579865875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgOlFOMg5BbXwesM95rqBPdXzdG1SCLKd7sYSHjrCK0=;
 b=ZTeo4zXi77AXSMGFlB7QMJoKYuvmrvN8UpaParEPtZa1u888dfpZh7vFVdTlufnqUdm6Ej
 n2EluKvJQXzewQ/hNunP+SB9r4ckR3rhlVJUnoFCEe8lzJ43K9rWJUJmTUY0YNX9rPSyMO
 Sn9BTb11KJ9e368kx4Emgh3OWKNvBE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-FjMaUzGRNEeCJ6DljxhLRw-1; Fri, 24 Jan 2020 06:37:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A150100550E
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:37:53 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0941E5C1BB;
 Fri, 24 Jan 2020 11:37:48 +0000 (UTC)
Date: Fri, 24 Jan 2020 11:37:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 12/21] multifd: multifd_queue_page only needs the
 qemufile
Message-ID: <20200124113746.GJ2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-13-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-13-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FjMaUzGRNEeCJ6DljxhLRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 19caf5ed4d..d4c829bc77 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -974,7 +974,7 @@ static int multifd_send_pages(QEMUFile *f)
>      return 1;
>  }
> =20
> -static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t =
offset)
> +static int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t o=
ffset)
>  {
>      MultiFDPages_t *pages =3D multifd_send_state->pages;
> =20
> @@ -993,12 +993,12 @@ static int multifd_queue_page(RAMState *rs, RAMBloc=
k *block, ram_addr_t offset)
>          }
>      }
> =20
> -    if (multifd_send_pages(rs->f) < 0) {
> +    if (multifd_send_pages(f) < 0) {
>          return -1;
>      }
> =20
>      if (pages->block !=3D block) {
> -        return  multifd_queue_page(rs, block, offset);
> +        return  multifd_queue_page(f, block, offset);
>      }
> =20
>      return 1;
> @@ -2128,7 +2128,7 @@ static int ram_save_page(RAMState *rs, PageSearchSt=
atus *pss, bool last_stage)
>  static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
>                                   ram_addr_t offset)
>  {
> -    if (multifd_queue_page(rs, block, offset) < 0) {
> +    if (multifd_queue_page(rs->f, block, offset) < 0) {
>          return -1;
>      }
>      ram_counters.normal++;
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


