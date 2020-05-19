Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21750C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA78020709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 06:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQDUCr6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA78020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1javzf-0001MP-2b
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 02:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javyr-0000hG-F7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:44:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1javyq-0008Qw-H5
 for qemu-devel@nongnu.org; Tue, 19 May 2020 02:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589870639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4kTwuIzndn2N3YI+Exhx9v2mrxWVjydNu4qMM/np1I=;
 b=TQDUCr6EzglTQGP9ywuW7tFV5FA80WfW1R3xfxAEhQvDfBYfB59s91YUVDBmJH5mytI6Bc
 x/k7E5gpwvtMXZCxQk5pMa391hE5ZUc0Mq9wdIGusn2Q2gfpfmLaAnnOOsNpczdpSGrfYm
 FekONhSiFtwhYgSyqPi6lFKdBSbykng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-9EHruyNTMzi3q6DkGsEK9A-1; Tue, 19 May 2020 02:43:47 -0400
X-MC-Unique: 9EHruyNTMzi3q6DkGsEK9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9F81800D42
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:43:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0DA5C1BB;
 Tue, 19 May 2020 06:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 877F811358BC; Tue, 19 May 2020 08:43:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH not-for-merge 2/5] qom: Make "info qom-tree" show children
 sorted
References: <20200518051945.8621-1-armbru@redhat.com>
 <20200518051945.8621-3-armbru@redhat.com>
 <c6eae4be-7d00-bc47-f5a0-4a5977136ac0@redhat.com>
Date: Tue, 19 May 2020 08:43:44 +0200
In-Reply-To: <c6eae4be-7d00-bc47-f5a0-4a5977136ac0@redhat.com> (Eric Blake's
 message of "Mon, 18 May 2020 16:04:19 -0500")
Message-ID: <87o8qk4e73.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 5/18/20 12:19 AM, Markus Armbruster wrote:
>> "info qom-tree" prints children in unstable order.  This is a pain
>> when diffing output for different versions to find change.  Print it
>> sorted.
>
> Yes, this does seem reasonable to include even without the rest of the
> series.

Noted.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qom/qom-hmp-cmds.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
>> index 4a61ee1b8c..cf0af8f6b5 100644
>> --- a/qom/qom-hmp-cmds.c
>> +++ b/qom/qom-hmp-cmds.c
>> @@ -78,6 +78,35 @@ static int print_qom_composition_child(Object *obj, void *opaque)
>>       return 0;
>>   }
>>   +static int qom_composition_compare(const void *a, const void *b,
>> void *ignore)
>> +{
>> +    Object *obja = (void *)a, *objb = (void *)b;
>
> Casting away const...
>
>> +    const char *namea, *nameb;
>> +
>> +    if (obja == object_get_root()) {
>> +        namea = g_strdup("");
>> +    } else {
>> +        namea = object_get_canonical_path_component(obja);
>
> ...should we instead improve object_get_canonical_path_component to
> work with 'const Object *'?

Go right ahead :)

I need to sit on my hands to have a chance getting my task queue back
under control.

>> +    }
>> +
>> +    if (objb == object_get_root()) {
>> +        nameb = g_strdup("");
>> +    } else {
>> +        nameb = object_get_canonical_path_component(objb);
>> +    }
>> +
>> +
>> +    return strcmp(namea, nameb);
>
> Why the two blank lines?  This leaks namea and/or nameb if either
> object is the object root.  Should you instead use g_strcmp0 here,
> with namea/b set to NULL instead of g_strdup("") above?

My not-for-merge proves prudent ;)

>> @@ -105,7 +134,16 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>>       monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
>>                      object_get_typename(obj));
>>       g_free(name);
>> -    object_child_foreach(obj, print_qom_composition_child, &s);
>> +
>> +    GQueue children;
>> +    Object *child;
>
> Mid-function declarations - I assume you'd clean this up if we want
> this for real?

Yes.  I prioritized diff over maintainability, because not-for-merge.

>> +    g_queue_init(&children);
>> +    object_child_foreach(obj, insert_qom_composition_child, &children);
>> +    while ((child = g_queue_pop_head(&children))) {
>> +        print_qom_composition(mon, child, indent + 2);
>> +    }
>> +    (void)s;
>> +    (void)print_qom_composition_child;
>
> Also, this looks like leftover debugger aids?

Shut up the compiler so I don't have to remove code.  Shorter diff,
not-for-merge.

>>   }
>>     void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
>>

Thanks!


