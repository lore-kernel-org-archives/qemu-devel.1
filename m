Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8CC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793B321D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nu0mJ1EO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793B321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVzb-0006np-B9
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZVyk-0005f6-CE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZVyi-0003uZ-Fn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604308695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIpUsyP2Xuy7MtX19dQOl5aELnUQOotmWQ7M+Fmz524=;
 b=Nu0mJ1EOKvzyN+Gv9HZCghCdGO5NoYADk9P2H2NOldzLvS4kww4HOpVjiz0mqCqhH+vpcj
 UA2Hrb2+KyfjVc/YhILX+ojhPy/zxGys0YAnJNCNxLpJYXzULBi0Vae+dhFf8Pl9nGz0Pr
 MexohoRYhEdxQoEPqQmSqnkRkU7dLLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-ZmxX50FoMGClAfSFWs9tvg-1; Mon, 02 Nov 2020 04:18:13 -0500
X-MC-Unique: ZmxX50FoMGClAfSFWs9tvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1790E801FD6;
 Mon,  2 Nov 2020 09:18:12 +0000 (UTC)
Received: from redhat.com (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ECC56CE50;
 Mon,  2 Nov 2020 09:18:06 +0000 (UTC)
Date: Mon, 2 Nov 2020 09:18:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
Message-ID: <20201102091804.GC134709@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
 <CAJ+F1CLW=zfWq3apgrKear2v42LYarSMQKw07BHadM-rYjcmoA@mail.gmail.com>
 <87pn50vxa0.fsf@dusky.pond.sub.org>
 <20201030102049.GI99222@redhat.com>
 <87zh40no5a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87zh40no5a.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, xiaoqiang zhao <zxq_yx_007@163.com>,
 QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 09:44:49AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Oct 30, 2020 at 11:11:19AM +0100, Markus Armbruster wrote:
> >> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> >> 
> >> > Hi Markus,
> >> >
> >> > On Thu, Oct 29, 2020 at 5:43 PM Markus Armbruster <armbru@redhat.com> wrote:
> >> >
> >> >> In my opinion, the Linux-specific abstract UNIX domain socket feature
> >> >> introduced in 5.1 should have been rejected.  The feature is niche,
> >> >> the interface clumsy, the implementation buggy and incomplete, and the
> >> >> test coverage insufficient.  Review fail.
> >> >>
> >> >
> >> > I also failed (as chardev maintainer..) to not only review but weigh in and
> >> > discuss the merits or motivations behind it.
> >> >
> >> > I agree with you. Also the commit lacks motivation behind this "feature".
> >> >
> >> >
> >> >> Fixing the parts we can still fix now is regrettably expensive.  If I
> >> >> had the power to decide, I'd unceremoniously revert the feature,
> >> >> compatibility to 5.1 be damned.  But I don't, so here we go.
> >> >>
> >> >> I'm not sure this set of fixes is complete.  However, I already spent
> >> >> too much time on this, so out it goes.  Lightly tested.
> >> >>
> >> >> Regardless, I *will* make time for ripping the feature out if we
> >> >> decide to do that.  Quick & easy way to avoid reviewing this series
> >> >> *hint* *hint*.
> >> >>
> >> >
> >> > well, fwiw, I would also take that approach too, to the risk of upsetting
> >> > the users.
> >> 
> >> Reverting the feature requires rough consensus and a patch.
> >> 
> >> I can provide a patch, but let's give everybody a chance to object
> >> first.
> 
> Daniel, do you object, yes or no?

Yes, I object to removing the feature as it is clearly useful.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


