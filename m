Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D7C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 16:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE122068F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOLkCG/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE122068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jueaA-00029Q-Qc
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 12:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jueZd-0001kP-5h
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 12:11:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jueZa-0005DG-HQ
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 12:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594570284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Sgrc0YmiBh6uLty5SoOaucHWsYj4SRJO89mpGF9Ygo=;
 b=IOLkCG/kuqZeEeTPokRQ8OV3Nufc9yC/5IxUH7rWifWJxR9LHpfcNLWCHGZWnnrhWAKxCv
 oTrIuWgcJ/ms8zsTL4YLaUKxmCKDjGuDWy5pP8kxs7VDjYIAvnvFmKI/CKMxjMOcSJPC9U
 TRdGAh480ZEFka5bMUEWXwkOo+302QU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-I6otRQozNeyKfjH1A_YSbw-1; Sun, 12 Jul 2020 12:11:22 -0400
X-MC-Unique: I6otRQozNeyKfjH1A_YSbw-1
Received: by mail-wr1-f70.google.com with SMTP id y16so14302725wrr.20
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 09:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Sgrc0YmiBh6uLty5SoOaucHWsYj4SRJO89mpGF9Ygo=;
 b=Ns0iFiLCvBmRA/DVAq4fkOBqam0nP8B8dO0vWYy5BrrZQlkJMZp0GprzOEwoG4DaaU
 TNl3QqptZOF/EP/E6jQCsi00Am1jVyHgV5+EOkssUHRFIWLM0hpJZpG6C6hB9vzZcE7p
 PXgJzYyWq4oMnsvfM23jysnhYMsT1X+T90m1FL+YwRzoOgvyXH4TvhwTg2FQ521pO12y
 Cr5XQBDr2bt81Gd0+9mIagGbIecSCiKHv0O7w/92EMt++MPIl3dyIRBQjDVYmaIwaUPD
 vfCeq8EkFHxgFoFFxq2dY9BPNtTAgEviAVuOD1TJavGGo37JI+/TM/vOqF8SEvHgC8oY
 85zQ==
X-Gm-Message-State: AOAM532or5J3mO3reBNzyMTuz8Xxlt0JsOezuTcumVs5WlF7xqT88iZ5
 cQ0q4YaS8GpYwu9obm5sTMI/WopVvnvRfHqieZDE6AtKVtfPU+B/1ctejkJvycs2Xy36gZMRIpX
 LW8pS6hjh9VK18ys=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr15715640wmj.73.1594570281601; 
 Sun, 12 Jul 2020 09:11:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgOZmJi+M5DU81LOvaeyKamgDUDR0RhfiDAv8oBaLSO3LN19FivXr0JlR+a9deFha3bCaa1g==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr15715620wmj.73.1594570281365; 
 Sun, 12 Jul 2020 09:11:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ef:39d9:1ecb:6054?
 ([2001:b07:6468:f312:ef:39d9:1ecb:6054])
 by smtp.gmail.com with ESMTPSA id r1sm19509652wrw.24.2020.07.12.09.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2020 09:11:20 -0700 (PDT)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Claudio Fontana <cfontana@suse.de>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
Date: Sun, 12 Jul 2020 18:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 12:11:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/20 12:00, Claudio Fontana wrote:
> Note: only the === -blockdev with a backing file === part of test 267 fails. -blockdev with NBD is ok, like all the rest.
> 
> 
> Interesting facts about s390 in particular: its save/load code includes the transfer of "storage keys",
> which include a buffer of 32768 bytes of keydata in the stream.
> 
> The code (hw/s390x/s390-skeys.c),
> is modeled similarly to RAM transfer (like in migration/ram.c), with an EOS (end of stream) marker.
> 
> Countrary to RAM transfer code though, after qemu_put_be64(f, EOS), the s390 code does not qemu_fflush(f).

1) Are there unexpected differences in the migration stream?  That is,
you could modify qcow2.c to fopen/fwrite/fclose the bytes as they're
written and read, and see if something does not match.

2) If it matches, are there unexpected differences other than the lack
of icount section when you apply the reproducer patch?

The fflush part makes me put more hope in the first, but both could help
you debug it.

Thanks,

Paolo


