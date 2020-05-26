Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E658C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BF32073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1jEC5QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BF32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWNz-0000EC-DQ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdWN4-0008DP-H9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:59:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jdWN2-0008Vs-Ta
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590487178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GmEDCmyFjF7Klnjix+jabk/rHIWwN9/miLi3aDH6qwA=;
 b=A1jEC5QQTUYK/Hlqb2DKhTmD203iaq94IpIcn5btxw7PhYVEERikF9MvBOhnPxbufC2Yjz
 ubTx3RBt25/0SBqPbFUmjajB/phgoGYFl0eeBf6H8PtQ+Qv1HJ5pkSY/iutQWgdmUZgHar
 m4s4HC5IKZBMLP/DUL1J5aB/So53z/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496--qBm_IBKOdWWyJ4bnybSeg-1; Tue, 26 May 2020 05:59:37 -0400
X-MC-Unique: -qBm_IBKOdWWyJ4bnybSeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D7480183C;
 Tue, 26 May 2020 09:59:36 +0000 (UTC)
Received: from [10.36.114.130] (ovpn-114-130.ams2.redhat.com [10.36.114.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA0F019D7C;
 Tue, 26 May 2020 09:59:30 +0000 (UTC)
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-51-armbru@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6278d057-85d2-0270-fa3c-4e456afd6cbb@redhat.com>
Date: Tue, 26 May 2020 11:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-51-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.05.20 16:55, Markus Armbruster wrote:
> init_event_facility() creates the SCLP events bus with two SCLP event
> devices (sclpquiesce and sclp-cpu-hotplug).  It leaves the devices
> unrealized.  A comment explains they will be realized "via the bus".
> 
> The bus's realize method sclp_events_bus_realize() indeed realizes all
> unrealized devices on this bus.  It carries a TODO comment claiming
> this "has to be done in common code".  No other bus realize method
> realizes its devices.
> 
> The common code in question is bus_set_realized(), which has a TODO
> comment asking for recursive realization.  It's been asking for years.
> 
> The only devices sclp_events_bus_realize() will ever realize are the
> two init_event_facility() puts there.
> 
> Simplify as follows:
> 
> * Make the devices members of the event facility instance struct, just
>   like the bus.  object_initialize_child() is simpler than
>   object_property_add_child() and object_unref().
> 
> * Realize them in the event facility realize method.
> 
> This is in line with how such things are done elsewhere.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/s390x/event-facility.c | 59 ++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 97a4f0b1f5..1ecaa20556 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -39,6 +39,7 @@ typedef struct SCLPEventsBus {
>  struct SCLPEventFacility {
>      SysBusDevice parent_obj;
>      SCLPEventsBus sbus;
> +    SCLPEvent quiesce, cpu_hotplug;
>      /* guest's receive mask */
>      union {
>          uint32_t receive_mask_pieces[2];
> @@ -328,34 +329,9 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>  
>  #define TYPE_SCLP_EVENTS_BUS "s390-sclp-events-bus"
>  
> -static void sclp_events_bus_realize(BusState *bus, Error **errp)
> -{
> -    Error *err = NULL;
> -    BusChild *kid;
> -
> -    /* TODO: recursive realization has to be done in common code */
> -    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> -        DeviceState *dev = kid->child;
> -
> -        object_property_set_bool(OBJECT(dev), true, "realized", &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> -    }
> -}
> -
> -static void sclp_events_bus_class_init(ObjectClass *klass, void *data)
> -{
> -    BusClass *bc = BUS_CLASS(klass);
> -
> -    bc->realize = sclp_events_bus_realize;
> -}
> -
>  static const TypeInfo sclp_events_bus_info = {
>      .name = TYPE_SCLP_EVENTS_BUS,
>      .parent = TYPE_BUS,
> -    .class_init = sclp_events_bus_class_init,
>  };
>  
>  static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
> @@ -443,27 +419,39 @@ static void init_event_facility(Object *obj)
>  {
>      SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
>      DeviceState *sdev = DEVICE(obj);
> -    Object *new;
>  
>      event_facility->mask_length = 4;
>      event_facility->allow_all_mask_sizes = true;
>      object_property_add_bool(obj, "allow_all_mask_sizes",
>                               sclp_event_get_allow_all_mask_sizes,
>                               sclp_event_set_allow_all_mask_sizes);
> +
>      /* Spawn a new bus for SCLP events */
>      qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus),
>                          TYPE_SCLP_EVENTS_BUS, sdev, NULL);
>  
> -    new = object_new(TYPE_SCLP_QUIESCE);
> -    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new);
> -    object_unref(new);
> -    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
> +    object_initialize_child(obj, TYPE_SCLP_QUIESCE,
> +                            &event_facility->quiesce,
> +                            TYPE_SCLP_QUIESCE);
>  
> -    new = object_new(TYPE_SCLP_CPU_HOTPLUG);
> -    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new);
> -    object_unref(new);
> -    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
> -    /* the facility will automatically realize the devices via the bus */
> +    object_initialize_child(obj, TYPE_SCLP_CPU_HOTPLUG,
> +                            &event_facility->cpu_hotplug,
> +                            TYPE_SCLP_CPU_HOTPLUG);
> +}
> +
> +static void realize_event_facility(DeviceState *dev, Error **errp)
> +{
> +    SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
> +    Error *local_err = NULL;
> +
> +    qdev_realize(DEVICE(&event_facility->quiesce),
> +                 BUS(&event_facility->sbus), &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
> +                 BUS(&event_facility->sbus), errp);
>  }
>  
>  static void reset_event_facility(DeviceState *dev)
> @@ -479,6 +467,7 @@ static void init_event_facility_class(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(sbdc);
>      SCLPEventFacilityClass *k = EVENT_FACILITY_CLASS(dc);
>  
> +    dc->realize = realize_event_facility;
>      dc->reset = reset_event_facility;
>      dc->vmsd = &vmstate_event_facility;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> 

Think you forgot

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


