Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A62C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784FE20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOc8rr3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784FE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Iz-0001sP-JO
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jr3Aa-00040I-CU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:38:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jr3AV-0007P3-Li
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593711518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWkiP2riByo+oCZwlGXBL90XYfCVObEALO4uM2yw4ao=;
 b=OOc8rr3TjHTAlUv4T1m4FRLRIDcivLsaqENbCn+J1yp/krASBeW9OIzjhT6uUYNPKB3TeL
 RrFS5DFB3OvIkhcz3yu4t7YtcuStAXIHPEx2A0JIAqCD8sDb9mRHwd4q5N6wTPQagx1PcW
 Y9vIzGztHR8aIVjMNGOQxXbkOBfCUJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-0yTqEWzZO_u7fbaHNtXhrA-1; Thu, 02 Jul 2020 13:38:33 -0400
X-MC-Unique: 0yTqEWzZO_u7fbaHNtXhrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A60981940922;
 Thu,  2 Jul 2020 17:38:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3CC101042D;
 Thu,  2 Jul 2020 17:38:31 +0000 (UTC)
Subject: Re: [PATCH] configure / util: Auto-detect the availability of
 openpty()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702143955.678-1-thuth@redhat.com>
 <20200702144650.GM1888119@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c7a0d182-8df1-9ac6-4ef1-65745ebf358a@redhat.com>
Date: Thu, 2 Jul 2020 19:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200702144650.GM1888119@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, qemu-devel@nongnu.org,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2020 16.46, Daniel P. Berrangé wrote:
> On Thu, Jul 02, 2020 at 04:39:55PM +0200, Thomas Huth wrote:
>> Recent versions of Solaris (v11.4) now feature an openpty() function,
>> too, causing a build failure since we ship our own implementation of
>> openpty() for Solaris in util/qemu-openpty.c so far. Since there are
>> now both variants available in the wild, with and without this function,
>> let's introduce a proper HAVE_OPENPTY define for this to fix the build
>> failure.
> 
> 11.4 has been out since Aug 2018
> 
> The previous verison of solaris  11.3 was from Oct 2015, with EOL
> in Oct 2020 [1].
> 
> Solaris isn't an officially supported platform for QEMU, but if it
> was, then we'd probably consider it a long life distro, and thus
> consider 11.3 to be out of scope for QEMU by now.
> 
> IOW, instead of checking for openpty being missing, I think there's
> a decent argument to be made that we can just assume openpty exists,
> and delete the old solaris compat code entirely.

I'd normally agree, but according to Peter, illumos also does not have 
this function yet:

  https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09276.html

... so I think we should keep it around for a little bit longer until at 
least the open source versions of Solaris have that function, too.
(Maybe someone will still finally provide a VM based on one of the 
illumos distros for our regression tests...?)

  Thomas


