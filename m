Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7CC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E669426A87
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E669426A87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiSv-0007yo-2B
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:25:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWiRu-0007Ya-JU
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWiRr-0007jl-F8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:24:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hWiRr-0007aM-5p
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78A6CA3EB1;
	Fri, 31 May 2019 14:23:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 25A1D1009976;
	Fri, 31 May 2019 14:23:46 +0000 (UTC)
Date: Fri, 31 May 2019 16:23:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190531162341.3743eb45@redhat.com>
In-Reply-To: <20190531134315.4109-14-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-14-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 31 May 2019 14:23:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v16 13/23] target/rx: Fix cpu types and
 names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 May 2019 08:43:05 -0500
Richard Henderson <richard.henderson@linaro.org> wrote:

> There was confusion here about abstract classes and naming cpus.
> We had registered a concrete class named "-rxcpu".  This was put
> into the default cpu fields, and matched, so basic tests worked.
> However, no value for -cpu could ever match in rx_cpu_class_by_name.
> 
> Rename the base class to "rx-cpu" and make it abstract.  This
> matches what we do for most other targets.  Create a new concrete
> cpu with the name "rx62n-rx-cpu".

since it hasn't been merged yet, it would be better to squash this
fixup into 3/23

[...]

> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 3268077d08..41fe1de4bb 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -74,13 +74,14 @@ static void rx_cpu_list_entry(gpointer data, gpointer user_data)
>      const char *typename = object_class_get_name(OBJECT_CLASS(data));
>      int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
>  
> -    qemu_printf("%.*s\n", len, typename);
> +    qemu_printf("  %.*s\n", len, typename);
>  }
>  
>  void rx_cpu_list(void)
>  {
> -    GSList *list;
> -    list = object_class_get_list_sorted(TYPE_RXCPU, false);
> +    GSList *list = object_class_get_list_sorted(TYPE_RX_CPU, false);
> +
> +    qemu_printf("Available CPUs:\n");
>      g_slist_foreach(list, rx_cpu_list_entry, NULL);
>      g_slist_free(list);
>  }
> @@ -88,15 +89,17 @@ void rx_cpu_list(void)
>  static ObjectClass *rx_cpu_class_by_name(const char cpu_model)
>  {
>      ObjectClass *oc;
> -    char *typename = NULL;
> +    char *typename;
>  
> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
> +    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);

in case of new cpu, I'd allow only typename as cpu_model

s/typename/cpu_model/
  
which is compatible with '-device' naming and QMP/monitor interfaces
that we support.

and I would not add other naming schemes /like adding suffix to cpu_model or .../
that  are existing in QEMU for legacy reasons.


> -    if (oc != NULL && object_class_is_abstract(oc)) {
> -        oc = NULL;
> -    }
> -
>      g_free(typename);
> +
> +    if (oc == NULL ||
> +        object_class_is_abstract(oc) ||
> +        !object_class_dynamic_cast(oc, TYPE_RX_CPU)) {
> +        return NULL;
> +    }
>      return oc;
>  }
>  
[...]



