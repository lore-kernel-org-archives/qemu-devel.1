Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7963AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E668208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq01eD4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E668208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWn9B-0002Ly-Bk
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWn8I-0001BS-0Q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWn8G-0002Mb-Nu
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588883315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSxWDZsjj3SaGgtFx1GscCkXpWzyoWovCugop63z/1U=;
 b=Gq01eD4lmLJKvy69g1AJeVCq59hLq34yi7JcS2y2yVUoA/zXJ2ILyKNOn+x0OlDz/7YlT2
 fKPYAZTfrp3gelB9R/4bD4ktCa7wqDg7giAziSbJ0hGY40tac6xTDsegxsBsHceNjuvQD6
 M9+g9+4301HM5peexafNvEY6I6J2xI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-hN_DlCjLN7CG9P-XeVUyBg-1; Thu, 07 May 2020 16:28:29 -0400
X-MC-Unique: hN_DlCjLN7CG9P-XeVUyBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B13118FE860;
 Thu,  7 May 2020 20:28:28 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FCFD19C4F;
 Thu,  7 May 2020 20:28:25 +0000 (UTC)
Subject: Re: [PATCH] Fix erroneous double negation in conditional
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>, qemu-devel@nongnu.org,
 mst@redhat.com, qemu-trivial@nongnu.org
References: <CAFubqFt+KVJFYCEimgdTYRiiBm9y9ZRvSshxRv0kizRcUZTkLQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <62e04219-9254-3210-e948-e6049f535da3@redhat.com>
Date: Thu, 7 May 2020 15:28:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFubqFt+KVJFYCEimgdTYRiiBm9y9ZRvSshxRv0kizRcUZTkLQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:06 PM, Raphael Norwitz wrote:
> In vhost_migration_log() there is the following check:
>      if(!!enable =3D=3D dev->log_enabled) {
>          return 0;
>      }
>=20
> The double negative =E2=80=9C!!=E2=80=9D is unnecessary and bad coding st=
yle. This
> change removes it.

!!int or !!ptr is not bad coding style - it is the shortest way to=20
compare a non-bool against 0, and canonicalize the result back into bool=20
(that is, convert all non-zero values into '1').  But !!bool is a waste=20
of typing, since bool is already in the proper form.  Your patch as-is=20
is incorrect; since the function declares 'int enable', this is using=20
the !!int form which is not bad coding style.

On the other hand, looking at this function closer, we see that=20
vhost_migration_log() is static, so all uses lie within this file.  And=20
the callers are:

static void vhost_log_global_start(MemoryListener *listener)
     r =3D vhost_migration_log(listener, true);
static void vhost_log_global_stop(MemoryListener *listener)
     r =3D vhost_migration_log(listener, false);

and looking at struct vhost_dev, its log_enabled member is bool.

So the _real_ problem with this file is that it uses 'int enable' rather=20
than 'bool enable'.  And once you fix the parameter type, then you are=20
indeed correct that you would have a !!bool scenario worth cleaning up.

Looking forward to v2 along those lines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


