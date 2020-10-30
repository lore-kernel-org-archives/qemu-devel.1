Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B16C56201
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6D422202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRSAAVhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6D422202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOJi-0008QD-OI
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 02:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYOIp-0007gz-Fi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYOIn-0007s3-47
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 02:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604040859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phN/XX6YjPZZ2Dtz9G5/qPHEsZfyNI49FSc9OIWlNAk=;
 b=LRSAAVhvLLXaZVwwn6PMkAZllEEmDZmpsAzTooGDZl0fCRiLejJk3Nl82oFknWqmoCiTXP
 nzPrfcXmS4TCJY0QETl5Vkn8JJSV3ySnmkoND0VuBdb5KQCnZupjQaS6OKUqyxgVsGclgP
 lVxpfDBgyNNxm7FnoVGMwxKCVMIpyVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-NHccyYCoO8OCOZD2r-RdFw-1; Fri, 30 Oct 2020 02:54:13 -0400
X-MC-Unique: NHccyYCoO8OCOZD2r-RdFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D801007463;
 Fri, 30 Oct 2020 06:54:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 174C15C1C4;
 Fri, 30 Oct 2020 06:54:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E9BB113865F; Fri, 30 Oct 2020 07:54:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 07/11] sockets: Fix default of UnixSocketAddress member
 @tight
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-8-armbru@redhat.com>
 <388cd3a5-9f7f-79e0-b9ad-f5be86e4661d@redhat.com>
Date: Fri, 30 Oct 2020 07:54:04 +0100
In-Reply-To: <388cd3a5-9f7f-79e0-b9ad-f5be86e4661d@redhat.com> (Eric Blake's
 message of "Thu, 29 Oct 2020 14:34:07 -0500")
Message-ID: <871rhg19wz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/29/20 8:38 AM, Markus Armbruster wrote:
>> QMP chardev-add defaults absent member @tight to false instead of
>> true.  HMP chardev-add and CLI -chardev correctly default to true.
>> 
>> The previous commit demonstrated that socket_listen() and
>> socket_connect() are broken for absent @tight.  That explains why QMP
>> is broken, but not why HMP and CLI work.  We need to dig deeper.
>> 
>> An optional bool member of a QAPI struct can be false, true, or
>> absent.  In C, we have:
>> 
>> 	    has_MEMBER    MEMBER
>>     false         true	   false
>>     true	  true	   false
>>     absent	 false	false/ignore
>
> I'm not sure the TAB in this table made it very legible (it's hard to
> tell if has_MEMBER is the label of column 1 or 2).

Use of TAB is an accident.

> Row two is wrong: MEMBER (column 3) is set to true when the QMP code
> passed true on the wire.

Pasto, fixing...

Result:

            has_MEMBER    MEMBER
    false         true     false
    true          true      true
    absent       false  false/ignore

>> When has_MEMBER is false, MEMBER should be set to false on write, and
>> ignored on read.
>> 
>> unix_listen_saddr() and unix_connect_saddr() use member @tight without
>> checking @has_tight.  This is wrong.
>
> It generally works if addr was constructed by the same way as the
> generated QAPI parser code - but as you demonstrated, in this particular
> case, because our construction did not obey the rules of the QAPI
> parser, our lack of checking bit us.
>
>> When @tight was set to false as it should be, absent @tight defaults
>> to false.  Wrong, it should default to true.  This is what breaks QMP.
>> 
>> There is one exception: qemu_chr_parse_socket() leaves @has_tight
>> false when it sets @tight.  Wrong, but the wrongs cancel out.  This is
>> why HMP and CLI work.  Same for @has_abstract.
>> 
>> Fix unix_listen_saddr() and unix_connect_saddr() to default absent
>> @tight to true.
>> 
>> Fix qemu_chr_parse_socket() to set @has_tight and @has_abstract.
>
> At any rate, the fix looks correct:
> - as producers, anywhere we hand-construct an addr (rather than using
> generated QAPI code), we MUST set both has_MEMBER and MEMBER, including
> setting MEMBER to false if has_MEMBER is false, if we want to preserve
> the assumptions made in the rest of the code;
> - as consumers, rather than relying on the QAPI parsers only setting
> MEMBER to true when has_MEMBER is true, we can ensure that has_MEMBER
> has priority by checking it ourselves

As long as the instance is built according to the rules, you can
contract has_MEMBER && MEMBER to just MEMBER.  Both mean "true".

However, has_MEMBER && !MEMBER cannot be contracted to !MEMBER.  The
former means "false", the latter means "false or absent".

Doubters, see the table above.

Putting defaults in the schema would let us eliminate the "absent"
state, the has_MEMBER flags, and the bugs that come with them.  Sadly,
this project has been crowded out by more urgent or important work since
forever.

>> +++ b/util/qemu-sockets.c
>> @@ -919,7 +919,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>>      if (saddr->abstract) {
>>          un.sun_path[0] = '\0';
>>          memcpy(&un.sun_path[1], path, pathlen);
>> -        if (saddr->tight) {
>> +        if (!saddr->has_tight || saddr->tight) {
>>              addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
>>          }
>>      } else {
>> @@ -979,7 +979,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>>      if (saddr->abstract) {
>>          un.sun_path[0] = '\0';
>>          memcpy(&un.sun_path[1], saddr->path, pathlen);
>> -        if (saddr->tight) {
>> +        if (!saddr->has_tight || saddr->tight) {
>>              addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
>>          }
>>      } else {
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


