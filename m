Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF24CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B770020772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMLi2vcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B770020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIRQ-0000uV-Vu
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHyR-0002Xg-Hp
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHyP-00059t-KB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLiFPedZRFmC0AexZwBUf3wTTbW2KerivS0D008x8Kg=;
 b=LMLi2vcGiPi+DmZ5EGKNz8+WE8p32sG1eUD7O18EBN/EPLWHrmUTWgPcTabLxtmGrscVCf
 TccPqmxfFF9iThwHzRHdWo4CPZSitSX4QM/1mGSGr8Pm0DYbX3LvLLyR75Td8liPQw2kyf
 8yN8Nasc0vqg1wYjw8+yF0ElRfPfWkw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-dDXY3wzsPUaQVSAfHwgUww-1; Wed, 08 Jul 2020 11:48:51 -0400
X-MC-Unique: dDXY3wzsPUaQVSAfHwgUww-1
Received: by mail-wm1-f71.google.com with SMTP id g138so3370711wme.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GLiFPedZRFmC0AexZwBUf3wTTbW2KerivS0D008x8Kg=;
 b=uVKaK+DVRjfBW59pfYSZ7JRL7m8GEaHOpphb21v2GxX4daFq8W6mr7xztfgFBmZ+g6
 9XDrkG/kOKXhw/xA+80JrAmZstdJcK1PChRqTsam0PtDdDgBsw3SPddFAEubPsiNIJAm
 OApiBi1Q0s1IYrLpaPTvuHqsF4tttY/qkQ7ofYwORsdHo+2S9uGkau7Dv7uqxJlkhZP/
 0duNJMC0try4Mm2Ff2r5OFrpSesMWLV9aeukKtFaKIYFzSdBmsycyNNUi74bqnglr61W
 1+SC+nkwFpwwHaJYgX2G9UTuQeurbDDmOy3tLJtKkTsOEhaw/q9BWAxMsjLh5Ercb0iN
 XNoQ==
X-Gm-Message-State: AOAM533ZOUdZ1Pa2e5l9mRdxdnRrrxbwEm6hGTwMQZKWQRq9TdMfDXyV
 Ur59ar1E/vssY5ufxabm3Es/osc8j5z2pSjfFwPnJlAVnf/pVhMDjhwD6hu/Bts00BImV06707T
 ngCBKmEnAw4v+nyA=
X-Received: by 2002:adf:ff87:: with SMTP id j7mr55859561wrr.128.1594223329855; 
 Wed, 08 Jul 2020 08:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOPN7JunU5a4BhseQ6pdzGafygsFab74UiuRV0vzjzvxDTGXQF7/QepuIlPMnO2jvlWMwAUw==
X-Received: by 2002:adf:ff87:: with SMTP id j7mr55859539wrr.128.1594223329540; 
 Wed, 08 Jul 2020 08:48:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id z63sm340330wmb.2.2020.07.08.08.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:48:49 -0700 (PDT)
Subject: Re: [PULL 13/29] qapi: Flatten object-add
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
 <20200306171458.1848-14-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7dc27dad-7797-dc2a-9456-2a7aaf9a4e5c@redhat.com>
Date: Wed, 8 Jul 2020 17:48:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200306171458.1848-14-kwolf@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 18:14, Kevin Wolf wrote:
> Mapping object-add to the command line as is doesn't result in nice
> syntax because of the nesting introduced with 'props'. This becomes
> nicer and more consistent with device_add and netdev_add when we accept
> properties for the object on the top level instead.
> 
> 'props' is still accepted after this patch, but marked as deprecated.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Message-Id: <20200224143008.13362-8-kwolf@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Hi Kevin and Markus,

I just noticed this patch.  In my opinion "nice syntax" is not a good
argument for having a "gen: false" command that is even less
introspectable than the "props" argument.

As an aside, it would have been nice to run this through Markus and me,
though in all fairness I'm not sure I would have been responsive back in
February.

I would like to un-deprecate this for 5.1, and revert it in either 5.1
or 5.2.  (Also I will be away next week, so the decision would have to
be taken quickly).

Paolo


> ---
>  qapi/qom.json                   | 12 +++++++---
>  docs/system/deprecated.rst      |  5 ++++
>  include/qom/object_interfaces.h |  7 ++++++
>  hw/block/xen-block.c            | 11 ++++++++-
>  monitor/misc.c                  |  2 ++
>  qom/qom-qmp-cmds.c              | 42 +++++++++++++++++++++++++++------
>  6 files changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index ecc60c4401..8abe998962 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -210,7 +210,12 @@
>  #
>  # @id: the name of the new object
>  #
> -# @props: a dictionary of properties to be passed to the backend
> +# @props: a dictionary of properties to be passed to the backend. Deprecated
> +#         since 5.0, specify the properties on the top level instead. It is an
> +#         error to specify the same option both on the top level and in @props.
> +#
> +# Additional arguments depend on qom-type and are passed to the backend
> +# unchanged.
>  #
>  # Returns: Nothing on success
>  #          Error if @qom-type is not a valid class name
> @@ -221,12 +226,13 @@
>  #
>  # -> { "execute": "object-add",
>  #      "arguments": { "qom-type": "rng-random", "id": "rng1",
> -#                     "props": { "filename": "/dev/hwrng" } } }
> +#                     "filename": "/dev/hwrng" } }
>  # <- { "return": {} }
>  #
>  ##
>  { 'command': 'object-add',
> -  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
> +  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'},
> +  'gen': false } # so we can get the additional arguments
>  
>  ##
>  # @object-del:
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 1eaa559079..6c1d9034d9 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -190,6 +190,11 @@ Use ``migrate-set-parameters`` instead.
>  
>  Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.
>  
> +``object-add`` option ``props`` (since 5.0)
> +'''''''''''''''''''''''''''''''''''''''''''
> +
> +Specify the properties for the object as top-level arguments instead.
> +
>  ``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
> index 3e4e1d928b..6f92f3cebb 100644
> --- a/include/qom/object_interfaces.h
> +++ b/include/qom/object_interfaces.h
> @@ -162,4 +162,11 @@ void user_creatable_del(const char *id, Error **errp);
>   */
>  void user_creatable_cleanup(void);
>  
> +/**
> + * qmp_object_add:
> + *
> + * QMP command handler for object-add. See the QAPI schema for documentation.
> + */
> +void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp);
> +
>  #endif
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 686bbc3f0d..3885464513 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -18,6 +18,7 @@
>  #include "qapi/visitor.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qom/object_interfaces.h"
>  #include "hw/xen/xen_common.h"
>  #include "hw/block/xen_blkif.h"
>  #include "hw/qdev-properties.h"
> @@ -858,10 +859,18 @@ static XenBlockIOThread *xen_block_iothread_create(const char *id,
>  {
>      XenBlockIOThread *iothread = g_new(XenBlockIOThread, 1);
>      Error *local_err = NULL;
> +    QDict *opts;
> +    QObject *ret_data;
>  
>      iothread->id = g_strdup(id);
>  
> -    qmp_object_add(TYPE_IOTHREAD, id, false, NULL, &local_err);
> +    opts = qdict_new();
> +    qdict_put_str(opts, "qom-type", TYPE_IOTHREAD);
> +    qdict_put_str(opts, "id", id);
> +    qmp_object_add(opts, &ret_data, &local_err);
> +    qobject_unref(opts);
> +    qobject_unref(ret_data);
> +
>      if (local_err) {
>          error_propagate(errp, local_err);
>  
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 6c41293102..1748ab3911 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -248,6 +248,8 @@ static void monitor_init_qmp_commands(void)
>                           QCO_NO_OPTIONS);
>      qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
>                           QCO_NO_OPTIONS);
> +    qmp_register_command(&qmp_commands, "object-add", qmp_object_add,
> +                         QCO_NO_OPTIONS);
>  
>      QTAILQ_INIT(&qmp_cap_negotiation_commands);
>      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 6136efec16..49db926fcc 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "block/qdict.h"
>  #include "hw/qdev-core.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-qdev.h"
> @@ -240,13 +241,34 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>      return prop_list;
>  }
>  
> -void qmp_object_add(const char *type, const char *id,
> -                    bool has_props, QObject *props, Error **errp)
> +void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp)
>  {
> +    QObject *props;
>      QDict *pdict;
>      Visitor *v;
>      Object *obj;
> +    const char *type;
> +    const char *id;
>  
> +    type = qdict_get_try_str(qdict, "qom-type");
> +    if (!type) {
> +        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
> +        return;
> +    } else {
> +        type = g_strdup(type);
> +        qdict_del(qdict, "qom-type");
> +    }
> +
> +    id = qdict_get_try_str(qdict, "id");
> +    if (!id) {
> +        error_setg(errp, QERR_MISSING_PARAMETER, "id");
> +        return;
> +    } else {
> +        id = g_strdup(id);
> +        qdict_del(qdict, "id");
> +    }
> +
> +    props = qdict_get(qdict, "props");
>      if (props) {
>          pdict = qobject_to(QDict, props);
>          if (!pdict) {
> @@ -254,17 +276,23 @@ void qmp_object_add(const char *type, const char *id,
>              return;
>          }
>          qobject_ref(pdict);
> -    } else {
> -        pdict = qdict_new();
> +        qdict_del(qdict, "props");
> +        qdict_join(qdict, pdict, false);
> +        if (qdict_size(pdict) != 0) {
> +            error_setg(errp, "Option in 'props' conflicts with top level");
> +            qobject_unref(pdict);
> +            return;
> +        }
> +        qobject_unref(pdict);
>      }
>  
> -    v = qobject_input_visitor_new(QOBJECT(pdict));
> -    obj = user_creatable_add_type(type, id, pdict, v, errp);
> +    v = qobject_input_visitor_new(QOBJECT(qdict));
> +    obj = user_creatable_add_type(type, id, qdict, v, errp);
>      visit_free(v);
>      if (obj) {
>          object_unref(obj);
>      }
> -    qobject_unref(pdict);
> +    *ret_data = QOBJECT(qdict_new());
>  }
>  
>  void qmp_object_del(const char *id, Error **errp)
> 


