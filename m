Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A9F206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhn0KDMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUxO-0006EM-OG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtUwj-0005nB-Ac
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:42:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtUwh-0003r2-RJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594294950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O3AcFV4MrSzWzboIWpst2gjfaCJaL1e3u9J77xugnxY=;
 b=Nhn0KDMDjLpdGPQzSpOZ4L9jopjm0rCjv2YvTQsS4wA+tyuwsToGjH8Ho1Wh07PDG8eHMd
 2TX9gU+09J+XpR7rCi9Uv9LHwa5lJDUoCtT9+WayQoGnFuDIJysawdUCkBe9w+jvhK/tvA
 GdkPpWK/a0lBrrhAQ3Uehn1kQA3DJ3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-f9hv5HCrMtCpx7i_sNT6iw-1; Thu, 09 Jul 2020 07:42:28 -0400
X-MC-Unique: f9hv5HCrMtCpx7i_sNT6iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88E310059A2;
 Thu,  9 Jul 2020 11:42:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9CD419D7B;
 Thu,  9 Jul 2020 11:42:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4674A1132FD2; Thu,  9 Jul 2020 13:42:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 2/7] Implement drain_call_rcu and use it in
 hmp_device_del
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-3-mlevitsk@redhat.com>
Date: Thu, 09 Jul 2020 13:42:23 +0200
In-Reply-To: <20200511160951.8733-3-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Mon, 11 May 2020 19:09:46 +0300")
Message-ID: <87wo3csyn4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> This allows to preserve the semantics of hmp_device_del,
> that the device is deleted immediatly which was changed by previos
> patch that delayed this to RCU callback
>
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  include/qemu/rcu.h |  1 +
>  qdev-monitor.c     |  3 +++
>  util/rcu.c         | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 570aa603eb..0e375ebe13 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -133,6 +133,7 @@ struct rcu_head {
>  };
>  
>  extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
> +extern void drain_call_rcu(void);
>  
>  /* The operands of the minus operator must have the same type,
>   * which must be the one that we specify in the cast.
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 56cee1483f..70877840a2 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -812,6 +812,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>          return;
>      }
>      dev = qdev_device_add(opts, &local_err);
> +    drain_call_rcu();
> +
>      if (!dev) {
>          error_propagate(errp, local_err);
>          qemu_opts_del(opts);
> @@ -904,6 +906,7 @@ void qmp_device_del(const char *id, Error **errp)
>          }
>  
>          qdev_unplug(dev, errp);
> +        drain_call_rcu();
>      }
>  }
>  

Subject claims "in hmp_device_del", code has it in qmp_device_add() and
qmp_device_del().  Please advise.

[...]


