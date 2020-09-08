Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749EAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D692245B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8B3GjWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D692245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFdDH-0003Zr-18
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kFdCh-00039s-Ao
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:58:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kFdCe-0003Z8-2F
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599569906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hG2Ldn+a3IpkEqQSX+p74FSpy0kCdEk8+hu+/9+5PnA=;
 b=L8B3GjWEib+uVKVZl+LcBww5Xn/heQR9pR+YHvn03zOPO/z4AT5kmJDIN0r7/fsEBhU+Bt
 q1ICd2/zfBQJmTJNnsrRR78DvSpvguvuY8VXEZE+Wvd7b85fYkT6HsKSbPGvIfRdP65aqK
 PPiB4x/V/9rzTA+GFwFLMXbJv+1WvcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-8eAjpE6KPASl_4CSlt4iIA-1; Tue, 08 Sep 2020 08:58:21 -0400
X-MC-Unique: 8eAjpE6KPASl_4CSlt4iIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B69D10054FF;
 Tue,  8 Sep 2020 12:58:20 +0000 (UTC)
Received: from [10.3.112.176] (ovpn-112-176.phx2.redhat.com [10.3.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A1427BD2;
 Tue,  8 Sep 2020 12:58:19 +0000 (UTC)
Subject: Re: [Bug 1894781] [NEW] [Feature request] Provide a way to do TLS
 first in QEMU/NBD connections (not after NBD negotiation)
To: Bug 1894781 <1894781@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <159953760175.19565.14791337348074084173.malonedeb@gac.canonical.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8c96f798-19c0-558a-ce82-e04a9d721a92@redhat.com>
Date: Tue, 8 Sep 2020 07:58:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159953760175.19565.14791337348074084173.malonedeb@gac.canonical.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 11:00 PM, Vjaceslavs Klimovs wrote:
> Public bug reported:
> 
> (following from
> https://gitlab.com/libvirt/libvirt/-/issues/68#note_400960567)
> 
> As is very well explained in https://www.berrange.com/posts/2016/04/05
> /improving-qemu-security-part-5-tls-support-for-nbd-server-client/, and
> easily confirmed with captures, NBD stream starts in cleartext and
> upgrades to TLS inline (similar to STARTTLS mechanism). As a rationale,
> it is stated that this provides better error messages for the user of
> NBD.
> 
> However, this approach has downsides:
> 
> 1) Clear indication to a network observer that NBD (and therefore likely qemu/libvirt) is used.

qemu/libvirt is not the only client of NBD.  In fact, the nbdkit and 
libnbd projects exist to make it easier to utilize NBD from more places.

> In contrast, TLS1.3 hides even the SNI of the servers (ESNI, https://blog.cloudflare.com/encrypted-sni/).
> 2) Potential for bugs in NBD protocol negotiation code. That code just statistically, likely less looked at code than gnutls. This is not a reflection on NBD code quality, just the fact that TLS code does receive a bit more scrutiny.

This is a non-argument.  When configured correctly at the NBD server, 
the NBD_OPT_STARTTLS option is the _only_ option accepted by a client, 
at which point you are right back into TLS code (from gnutls or 
elsewhere) and using the existing TLS libraries to establish the 
connection - but that is the SAME thing you would have to do even if 
there were a way to connect to an NBD server that doesn't even start 
with plaintext handshaking.

> 3) Inability to inspect TLS listener interface for compliance, e.g. with a security scanner. Making sure TLS listeners only select certain ciphersuits is a requirement of some compliance regimes.
> 
> I think it's fully possible to satisfy the original requirement of good
> error messages as well, detecting that the other end is initiating TLS
> connection.

If you are going to make a change in this area, it will need to be 
agreed on in the upstream NBD list, where _all_ implementations of NBD 
(both client and server) can weigh in; qemu will not change in a vacuum 
without upstream protocol concurrence.

https://lists.debian.org/nbd/

> 
> It's very unlikely that it's currently sae to recommend to run QEMU
> migration stream over a hostile network, but it should be possible to do
> with TLS only option.

It is very easy to write both servers and clients that require a 
transition from plaintext into TLS before any serious traffic is sent.

> 
> Solution to this, just like in the case of SMTP, is to provide TLS only
> option (no initial cleartext at all) for QEMU migration, which hopefully
> it not a large addition.
> 
> Thank you for your consideration!
> 
> ** Affects: qemu
>       Importance: Undecided
>           Status: New
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


