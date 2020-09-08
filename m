Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D25C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710CE2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHM0hk9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710CE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFc2t-00022S-LN
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFc0t-0008EV-Cg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50212
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFc0o-0001nm-Ve
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599565329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aEM7wUGBgb03M+f0GbRxI5p1ThDXu/ar/hchkNF65Lw=;
 b=jHM0hk9nWFv1NCw/igg+giB+8McBoU86qO75EEuQXzc+xBkPPT3xmJ/Dx1a8vHY5VArQ9C
 bBkpsVCvCNW4gI6Aj3bd3PQfRkd/8RAOb6SGL6BK4tpueAFm/2O6jwPYbGahOGAMTGaS/5
 IQ1HCfwPO2K7RK4jKiW9UL9enzblfUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-hso7w-KTNDejebGudVUovA-1; Tue, 08 Sep 2020 07:42:00 -0400
X-MC-Unique: hso7w-KTNDejebGudVUovA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8AA61005E5B
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 11:41:59 +0000 (UTC)
Received: from redhat.com (ovpn-113-154.ams2.redhat.com [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22CB85C1BB;
 Tue,  8 Sep 2020 11:41:55 +0000 (UTC)
Date: Tue, 8 Sep 2020 12:41:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/socket-helpers: Only fail socket protocol check if
 it is really necessary
Message-ID: <20200908114153.GG899163@redhat.com>
References: <20200908105435.218715-1-thuth@redhat.com>
 <20200908110715.GF899163@redhat.com>
 <7a78c69d-28f4-e73b-4acc-fc8dd923db3e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7a78c69d-28f4-e73b-4acc-fc8dd923db3e@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 01:27:46PM +0200, Thomas Huth wrote:
> On 08/09/2020 13.07, Daniel P. Berrangé wrote:
> > On Tue, Sep 08, 2020 at 12:54:35PM +0200, Thomas Huth wrote:
> >> The tests/test-char test is currently always failing on my system since
> >> socket_can_bind_connect("::1", PF_INET6) fails with EINVAL and thus
> >> socket_check_protocol_support() is returning -1 for an error. But IPv4
> >> is working fine. The logic in socket_check_protocol_support() seems to
> >> be wrong here, if either IPv6 or IPv4 is working, we should not return
> >> an error here. Thus rework the function to only return errors if both
> >> checks failed.
> > 
> > Can you tell me which exact syscall is giving EINVAL in this scenario ?
> 
> getaddrinfo() fails with -2 (EAI_NONAME ?). The logic in
> socket_can_bind_connect() then translates this into EINVAL.

Ok, lets just translate EAI_NONAME into  EADDRNOTAVAIL as we do for
the other getaddrinfo errors we want to treat as soft-failures

> 
> [...]
> >> -    if (socket_can_bind_connect("::1", PF_INET6) < 0) {
> >> -        if (errno != EADDRNOTAVAIL) {
> >> -            return -1;
> >> -        }
> >> -    } else {
> >> -        *has_ipv6 = true;
> >> +    errv6 = socket_can_bind_connect("::1", PF_INET6);
> >> +    *has_ipv6 = (errv6 == 0);
> >> +
> >> +    if (!*has_ipv4 && !*has_ipv6 &&
> >> +        (errv4 != EADDRNOTAVAIL || errv6 != EADDRNOTAVAIL)) {
> >> +        return -1;
> >>      }
> > 
> > The return value of socket_can_bind_connect is either 0 or -1,
> > but you're treating it an errno which isn't right.
> 
> Uh, where's my brown paperbag? ... looks like I need more coffee today...
> 
>  Thomas
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


