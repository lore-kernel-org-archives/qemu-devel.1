Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC645C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9739D2076E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APqBXevv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9739D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnlS4-0004l5-Mr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnlRM-00048P-Ce
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:06:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnlRJ-0006HZ-TI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592928384;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0US6GDuh07pH8weAGaDvQ4hRB7czZAk5H3N2hrRoNqk=;
 b=APqBXevvDctaiOTUGut8ukFqAnBtgGX1LalQ+b67HPbx260eqJUEpMPhTwAElQ4L3dG3sK
 6eGxawK/qlZ5nDhA94A2wsI9+p0ItmOLjTnV9tzEPp01jmKTWgCYBf4mdyyLL3lbo0D46r
 c66CaS8TGFf7VUW9bWUXkslNBydpxSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-GoJGm2OmOSWu6fzGZxfBzQ-1; Tue, 23 Jun 2020 12:05:54 -0400
X-MC-Unique: GoJGm2OmOSWu6fzGZxfBzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA791194092C;
 Tue, 23 Jun 2020 16:05:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63FD9101E66C;
 Tue, 23 Jun 2020 16:05:11 +0000 (UTC)
Date: Tue, 23 Jun 2020 17:05:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] qom: Allow object_property_add_child() to fail
Message-ID: <20200623160508.GK751477@redhat.com>
References: <20200623155452.30954-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623155452.30954-1-eric.auger@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 05:54:52PM +0200, Eric Auger wrote:
> object_property_add() does not allow object_property_try_add()
> to gracefully fail as &error_abort is passed as an error handle.
> 
> However such failure can easily be triggered from the QMP shell when,
> for instance, one attempts to create an object with an id that already
> exists:
> 
> For instance, call twice:
> object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
> and QEMU aborts.
> 
> This behavior is undesired as a user/management application mistake
> in reusing a property ID shouldn't result in loss of the VM and live
> data within.
> 
> This patch introduces two new functions, object_property_add_err() and
> object_property_add_child_err() whose prototype features an error handle.
> object_property_add_child_err() now gets called from user_creatable_add_type.
> This solution was chosen instead of changing the prototype of existing
> functions because the number of existing callers is huge.
> 
> The error now is returned gracefully to the QMP client.
> 
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"return": {}}
> (QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
> {"error": {"class": "GenericError", "desc": "attempt to add duplicate property
> 'mem2' to object (type 'container')"}}
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/qom/object.h    | 24 ++++++++++++++++++++++--
>  qom/object.c            | 33 ++++++++++++++++++++++++++++-----
>  qom/object_interfaces.c |  7 +++++--
>  3 files changed, 55 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


