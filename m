Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F58AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4662073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMbX+S6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4662073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3kF-00018X-HB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3hk-0007Dt-PK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:13:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr3hi-0006aO-CG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593713577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98G4hyJgGw4xpgB0WlTQNTmrzIwrkh+wb+4men9bzls=;
 b=XMbX+S6Fdcx99U2+miNxtG96RjYlF+XZcza7mK8VgbS2/uwqMlxJuYKxWWt+3yY9p4AkdM
 PTkOPnxKcGxUG3AvLpbEVaJRaFjNi1kzjYguzc62Ji8pFbCB5NFyvcUwEyc46+fEbGaq4J
 hdHPnvsZAl9KR+R5fO9+tIiNT1JYtdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-5n77XgOeMqiEjjT_nfBaAw-1; Thu, 02 Jul 2020 14:12:55 -0400
X-MC-Unique: 5n77XgOeMqiEjjT_nfBaAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83B7E800C64;
 Thu,  2 Jul 2020 18:12:54 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B46D79225;
 Thu,  2 Jul 2020 18:12:53 +0000 (UTC)
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
Date: Thu, 2 Jul 2020 13:12:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702175754.2211821-3-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> savevm, loadvm and delvm are some of the few commands that have never
> been converted to use QMP. The primary reason for this lack of
> conversion is that they block execution of the thread for as long as
> they run.
> 
> Despite this downside, however, libvirt and applications using libvirt
> has used these commands for as long as QMP has existed, via the
> "human-monitor-command" passthrough command. IOW, while it is clearly
> desirable to be able to fix the blocking problem, this is not an
> immediate obstacle to real world usage.
> 
> Meanwhile there is a need for other features which involve adding new
> parameters to the commands. This is possible with HMP passthrough, but
> it provides no reliable way for apps to introspect features, so using
> QAPI modelling is highly desirable.
> 
> This patch thus introduces trival savevm, loadvm, delvm commands

trivial

> to QMP that are functionally identical to the HMP counterpart, including
> the blocking problem.

Should we name them 'x-savevm', 'x-loadvm', 'x-delvm' to give ourselves 
room to change them when we DO solve the blocking issue?  Or will the 
solution of the blocking issue introduce new QMP commands, at which 
point we can add QMP deprecation markers on these commands to eventually 
retire them?

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +++ b/qapi/migration.json
> @@ -1621,3 +1621,79 @@
>   ##
>   { 'event': 'UNPLUG_PRIMARY',
>     'data': { 'device-id': 'str' } }
> +
> +##
> +# @savevm:
> +#
> +# Save a VM snapshot
> +#
> +# @tag: name of the snapshot to create. If it already
> +# exists it will be replaced.
> +#
> +# Note that execution of the VM will be paused during the time
> +# it takes to save the snapshot
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "savevm",
> +#      "data": {
> +#         "tag": "my-snap"
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2

I guess you are NOT trying to make 5.1 soft freeze next week?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


