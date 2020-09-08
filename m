Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E8C2BBD0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD101208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh8LcB5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD101208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbou-0002eT-1r
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFbn6-0001M8-ML
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFbn1-0008DU-F6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599564473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSJ+kz9gJFV8JdxeUQVWtelrBjIdPn4qHWZeFW4BoPs=;
 b=Eh8LcB5s55ALWHtLpGhfdG5L3E+NYI6Ji5TJO+2+0XxRoJ8ELDIdu88h/OKUQIIbnX61oi
 lKmIZNNn0GsHjQYcRE1o8ZfPR5Flcg/vgd+QeNM/iCGVQlMNwnF/jlD4+iSmVxsv0sWjyV
 9HYAYNeAmDkUNCzARYcIDzbd1R2KCso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267--aW3tA8_MZiknRVDr9N_SA-1; Tue, 08 Sep 2020 07:27:51 -0400
X-MC-Unique: -aW3tA8_MZiknRVDr9N_SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F16B31800D41
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 11:27:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E05F9CBA;
 Tue,  8 Sep 2020 11:27:47 +0000 (UTC)
Subject: Re: [PATCH] tests/socket-helpers: Only fail socket protocol check if
 it is really necessary
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200908105435.218715-1-thuth@redhat.com>
 <20200908110715.GF899163@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7a78c69d-28f4-e73b-4acc-fc8dd923db3e@redhat.com>
Date: Tue, 8 Sep 2020 13:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200908110715.GF899163@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/2020 13.07, Daniel P. Berrangé wrote:
> On Tue, Sep 08, 2020 at 12:54:35PM +0200, Thomas Huth wrote:
>> The tests/test-char test is currently always failing on my system since
>> socket_can_bind_connect("::1", PF_INET6) fails with EINVAL and thus
>> socket_check_protocol_support() is returning -1 for an error. But IPv4
>> is working fine. The logic in socket_check_protocol_support() seems to
>> be wrong here, if either IPv6 or IPv4 is working, we should not return
>> an error here. Thus rework the function to only return errors if both
>> checks failed.
> 
> Can you tell me which exact syscall is giving EINVAL in this scenario ?

getaddrinfo() fails with -2 (EAI_NONAME ?). The logic in
socket_can_bind_connect() then translates this into EINVAL.

[...]
>> -    if (socket_can_bind_connect("::1", PF_INET6) < 0) {
>> -        if (errno != EADDRNOTAVAIL) {
>> -            return -1;
>> -        }
>> -    } else {
>> -        *has_ipv6 = true;
>> +    errv6 = socket_can_bind_connect("::1", PF_INET6);
>> +    *has_ipv6 = (errv6 == 0);
>> +
>> +    if (!*has_ipv4 && !*has_ipv6 &&
>> +        (errv4 != EADDRNOTAVAIL || errv6 != EADDRNOTAVAIL)) {
>> +        return -1;
>>      }
> 
> The return value of socket_can_bind_connect is either 0 or -1,
> but you're treating it an errno which isn't right.

Uh, where's my brown paperbag? ... looks like I need more coffee today...

 Thomas


