Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B06C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D89720724
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCimleRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D89720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1jS-0000dF-FE
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kb1iG-0008GU-40
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kb1iC-0007IC-VX
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604669007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iavdSnXLJFV0Ry1gkT3SqOTcM1mAm7Kxt9CAo0322/I=;
 b=QCimleRY0HWIGh0a4Nlma9KaDquSLIkWPHur06U3yVrO8MmoJ1Ah0wL3mHUQGQOnpJop44
 l1r1Fw1PA4K2sC9u2+dn33hH+aw+SDAntrwr2EF2g+dz8CWvS6sUejJuFghR/PclKEhkMe
 6NB8VYMXLJkAI4rQUE67zxwssxRcDrA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-w-oTCcrKO2OEJMEWXko3KA-1; Fri, 06 Nov 2020 08:23:25 -0500
X-MC-Unique: w-oTCcrKO2OEJMEWXko3KA-1
Received: by mail-wr1-f72.google.com with SMTP id e3so461416wrn.19
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 05:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iavdSnXLJFV0Ry1gkT3SqOTcM1mAm7Kxt9CAo0322/I=;
 b=WR3I87jwTW7M/jD3uTwqCnSNy0xRGLBUtBOICaCiTcNRoP+fLVMJnR02TH6OiJahr2
 zuut2TedgUJbtov4S/AGnJ1A2+Zvfz9/n/+n6q9u5teR80V7Jh5Q962pA1zwyRA5diNT
 I+/h/bcePgAMVSLwEIMn1JqtTH3cTUlGVBlVnrF3S+23+RND0WFpAUYkPo0tFdYh1XVZ
 ebGfHJJxaYXYFOEozccFMXY0RAheVeE3BdiX/hZuS2DMxqYvawFSCCzpbdmblK8g88vr
 9u3LdsHeCQGAqjnMHoamvDfKWCMFl00nJu/XsMW2C7NEVqFF9PSURhGq7p9vMkJo4uMO
 j7sQ==
X-Gm-Message-State: AOAM531XjM+5BiQ1GzsPzTkEthZCH+TVdlPh+o6AH6Rix27NzgAhspp9
 Yfl57KJKWcoYjlASPHTBs+7MTcLcxDND1LfsF03QKToiYzJl2dSkXzAXrHHftDfu/SVqkFKAk0h
 p8VTTfVBNgozlnyU=
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr2554950wmc.181.1604669004449; 
 Fri, 06 Nov 2020 05:23:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9Lq8nxkowvMo6NpKeKrvXAGgOsoXIsbbPu8V4Ug7hC4vtiUIbsylKRTXyghvNXK7S6GTR6A==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr2554930wmc.181.1604669004274; 
 Fri, 06 Nov 2020 05:23:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id t4sm2251138wmb.20.2020.11.06.05.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 05:23:23 -0800 (PST)
Subject: Re: [PATCH for-5.2 3/4] qtest: escape device name in
 device-introspect-test
To: Markus Armbruster <armbru@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-4-pbonzini@redhat.com>
 <87zh3uiq2r.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10152819-aea1-364f-3c1d-98417fcb1395@redhat.com>
Date: Fri, 6 Nov 2020 14:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87zh3uiq2r.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/11/20 14:15, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> device-introspect-test uses HMP, so it should escape the device name
>> properly.  Because of this, a few devices that had commas in their
>> names were escaping testing.
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> $ git-grep '\.name *= *"[^"]*,' | cat
> hw/block/fdc.c:    .name          = "SUNW,fdtwo"
> 
> Any others?

Not that I know, but this is a bug anyway. :)

Paolo


