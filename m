Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC75C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33423206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fh1QZqNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33423206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPm7-0002R3-DX
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPlM-0001z4-UF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:13:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPlK-0001Zq-Eq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599041584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae8/iM77bXAkV8X+bj5U1bk3aI+7rEuZPBPceFLPgK0=;
 b=Fh1QZqNblKUZ/09LUD4LArn1rdexYUO9m9iZSVRGhdu821/ns1gkEqRYFYkKGtarpSZ6I6
 T0dLE8U4Q907ihebVsdee43sTrLnVUXiGF3WpcuUfFvfI3Sxb6kaeKI6VLXCGmQZ1D91sQ
 8rNBzDS3Xkoci+mCZiQtI95I6zQsKI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-fsBO9XtiOWapfElBdQOQAg-1; Wed, 02 Sep 2020 06:13:02 -0400
X-MC-Unique: fsBO9XtiOWapfElBdQOQAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11C9B189E60D;
 Wed,  2 Sep 2020 10:13:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB49419C59;
 Wed,  2 Sep 2020 10:12:57 +0000 (UTC)
Subject: Re: ui: fix potential compile error.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
References: <370e6ed66acf43e68f1ef2bffc3026f7@tencent.com>
 <20200902052313.unmxqfgsix6kuerb@sirius.home.kraxel.org>
 <20200902081713.GD403297@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54980bdc-662b-3632-46d2-3df02df9942d@redhat.com>
Date: Wed, 2 Sep 2020 12:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902081713.GD403297@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?B?cnVpcHBhbijmvZjnnb8p?= <ruippan@tencent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 10.17, Daniel P. Berrangé wrote:
> On Wed, Sep 02, 2020 at 07:23:13AM +0200, kraxel@redhat.com wrote:
>>   Hi,
>>
>>> 1.     CentOS7 with Python 2.7.5
>>
>>> Root cause is my argparse and python version. But change the invoking order can adapt both new and old argparse.
>>
>> python2 is EOL and not supported any more.
>> please "yum install python3" (yes, centos7 has it, was added in 7.8).
> 
> Hmm, I'm surpised the build even got this far.  configure should be checking
> python version and refusing to run with python2 at all before even starting
> the build process.

There is a check for python >= in the configure script. 潘睿, did the
"configure" script allow you to run with Python 2.7 ?

 Thomas


