Received: from eggs.gnu.org ([2001:4830:134:3::10]:43465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drina-00089k-69
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drinV-0002GO-6G
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:52:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1drinU-0002Fr-TY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:52:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8CApp8J128872
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:52:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cxb829spw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:52:03 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 12 Sep 2017 11:52:01 +0100
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-16-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 12 Sep 2017 12:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170911152150.12535-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7dc9925e-5a66-786b-6798-d42ad20b2d0a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 15/21] s390x: print CPU definitions in
 sorted order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/11/2017 05:21 PM, David Hildenbrand wrote:
> Other architectures provide nicely sorted lists, let's do it similarly on
> s390x.
> 
> While at it, clean up the code we have to touch either way.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

looks much nicer now, with the most important ones (new ones) still on screen. 


Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  target/s390x/cpu_models.c | 56 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 8e20e7637b..c295e641e6 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -270,16 +270,11 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
>      return last_compatible;
>  }
> 
> -struct S390PrintCpuListInfo {
> -    FILE *f;
> -    fprintf_function print;
> -};
> -
> -static void print_cpu_model_list(ObjectClass *klass, void *opaque)
> +static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
>  {
> -    struct S390PrintCpuListInfo *info = opaque;
> -    S390CPUClass *scc = S390_CPU_CLASS(klass);
> -    char *name = g_strdup(object_class_get_name(klass));
> +    CPUListState *s = user_data;
> +    const S390CPUClass *scc = S390_CPU_CLASS((ObjectClass *)data);
> +    char *name = g_strdup(object_class_get_name((ObjectClass *)data));
>      const char *details = "";
> 
>      if (scc->is_static) {
> @@ -290,21 +285,52 @@ static void print_cpu_model_list(ObjectClass *klass, void *opaque)
> 
>      /* strip off the -s390-cpu */
>      g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
> -    (*info->print)(info->f, "s390 %-15s %-35s %s\n", name, scc->desc,
> -                   details);
> +    (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s %s\n", name, scc->desc,
> +                      details);
>      g_free(name);
>  }
> 
> +static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
> +{
> +    const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
> +    const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
> +    const char *name_a = object_class_get_name((ObjectClass *)a);
> +    const char *name_b = object_class_get_name((ObjectClass *)b);
> +
> +    /* move qemu and host to the top of the list, qemu first, host second */
> +    if (name_a[0] == 'q') {
> +        return -1;
> +    } else if (name_b[0] == 'q') {
> +        return 1;
> +    } else if (name_a[0] == 'h') {
> +        return -1;
> +    } else if (name_b[0] == 'h') {
> +        return 1;
> +    }
> +
> +    /* keep the same order we have in our table (sorted by release date) */
> +    if (cc_a->cpu_def != cc_b->cpu_def) {
> +        return cc_a->cpu_def - cc_b->cpu_def;
> +    }
> +
> +    /* exact same definition - list base model first */
> +    return cc_a->is_static ? -1 : 1;
> +}
> +
>  void s390_cpu_list(FILE *f, fprintf_function print)
>  {
> -    struct S390PrintCpuListInfo info = {
> -        .f = f,
> -        .print = print,
> +    CPUListState s = {
> +        .file = f,
> +        .cpu_fprintf = print,
>      };
>      S390FeatGroup group;
>      S390Feat feat;
> +    GSList *list;
> 
> -    object_class_foreach(print_cpu_model_list, TYPE_S390_CPU, false, &info);
> +    list = object_class_get_list(TYPE_S390_CPU, false);
> +    list = g_slist_sort(list, s390_cpu_list_compare);
> +    g_slist_foreach(list, s390_print_cpu_model_list_entry, &s);
> +    g_slist_free(list);
> 
>      (*print)(f, "\nRecognized feature flags:\n");
>      for (feat = 0; feat < S390_FEAT_MAX; feat++) {
> 
