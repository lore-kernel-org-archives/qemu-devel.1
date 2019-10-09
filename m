Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025AAECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA0420679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA0420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGMt-0001wp-I1
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iI8jF-0007I8-Ff
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iI8jC-0000Jg-L7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:57:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iI8jC-0000JU-Aj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:57:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABA14308FBA6;
 Wed,  9 Oct 2019 09:57:52 +0000 (UTC)
Received: from work-vm (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6535C21F;
 Wed,  9 Oct 2019 09:57:46 +0000 (UTC)
Date: Wed, 9 Oct 2019 10:57:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support gtree migration
Message-ID: <20191009095743.GG2893@work-vm>
References: <20191004112025.28868-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004112025.28868-1-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 09 Oct 2019 09:57:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Auger (eric.auger@redhat.com) wrote:
> Introduce support for GTree migration. A custom save/restore
> is implemented. Each item is made of a key and a data.
> 
> If the key is a pointer to an object, 2 VMSDs are passed into
> the GTree VMStateField.
> 
> When putting the items, the tree is traversed in sorted order by
> g_tree_foreach.
> 
> On the get() path, gtrees must be allocated using the proper
> key compare, key destroy and value destroy. This must be handled
> beforehand, for example in a pre_load method.
> 
> Tests are added to test save/dump of structs containing gtrees
> including the virtio-iommu domain/mappings scenario.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Yes I think this is nice; only thing I'd add (other than Juan and
Peter's comments) is perhaps some tracing for when it all goes horribly
wrong!

Dave

> ---
> 
> v2 -> v3:
> - do not include glib.h anymore
> - introduce VMSTATE_GTREE_DIRECT_KEY_V
> - use pre_load to allocate the tree and remove data pointer
> - dump the number of nnodes and add checks on get path
> 
> v1 -> v2:
> - fix compilation issues reported by robots
> - fixed init of VMSD array
> - direct key now dumped as a 32b
> - removed useless cast from/to pointer
> ---
>  include/migration/vmstate.h |  40 ++++
>  migration/vmstate-types.c   | 136 ++++++++++++
>  tests/test-vmstate.c        | 421 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 597 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1fbfd099dd..98e5305d30 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -224,6 +224,7 @@ extern const VMStateInfo vmstate_info_unused_buffer;
>  extern const VMStateInfo vmstate_info_tmp;
>  extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
> +extern const VMStateInfo vmstate_info_gtree;
>  
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>  /*
> @@ -754,6 +755,45 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .start        = offsetof(_type, _next),                              \
>  }
>  
> +/*
> + * For migrating a GTree whose key is a pointer to _key_type and the
> + * value, a pointer to _val_type
> + * The target tree must have been properly initialized
> + * _vmsd: Start address of the 2 element array containing the key vmsd
> + *        and the data vmsd
> + * _key_type: type of the key
> + * _val_type: type of the value
> + */
> +#define VMSTATE_GTREE_V(_field, _state, _version, _vmsd,                       \
> +                        _key_type, _val_type)                                  \
> +{                                                                              \
> +    .name         = (stringify(_field)),                                       \
> +    .version_id   = (_version),                                                \
> +    .vmsd         = (_vmsd),                                                   \
> +    .info         = &vmstate_info_gtree,                                       \
> +    .start        = sizeof(_key_type),                                         \
> +    .size         = sizeof(_val_type),                                         \
> +    .offset       = offsetof(_state, _field),                                  \
> +}
> +
> +/*
> + * For migrating a GTree whose key is a uint32 and the value a pointer
> + * to _val_type
> + * The target tree must have been properly initialized
> + * _vmsd: data vmsd
> + * _val_type: type of the value
> + */
> +#define VMSTATE_GTREE_DIRECT_KEY_V(_field, _state, _version, _vmsd, _val_type) \
> +{                                                                              \
> +    .name         = (stringify(_field)),                                       \
> +    .version_id   = (_version),                                                \
> +    .vmsd         = (_vmsd),                                                   \
> +    .info         = &vmstate_info_gtree,                                       \
> +    .start        = 0,                                                         \
> +    .size         = sizeof(_val_type),                                         \
> +    .offset       = offsetof(_state, _field),                                  \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index bee658a1b2..cba8e660fe 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -691,3 +691,139 @@ const VMStateInfo vmstate_info_qtailq = {
>      .get  = get_qtailq,
>      .put  = put_qtailq,
>  };
> +
> +struct put_gtree_data {
> +    QEMUFile *f;
> +    const VMStateDescription *key_vmsd;
> +    const VMStateDescription *val_vmsd;
> +    QJSON *vmdesc;
> +    int ret;
> +};
> +
> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
> +{
> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
> +    QEMUFile *f = capsule->f;
> +    int ret;
> +
> +    qemu_put_byte(f, true);
> +
> +    /* put the key */
> +    if (!capsule->key_vmsd) {
> +        qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */
> +    } else {
> +        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
> +        if (ret) {
> +            capsule->ret = ret;
> +            return true;
> +        }
> +    }
> +
> +    /* put the data */
> +    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
> +    if (ret) {
> +        capsule->ret = ret;
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static int put_gtree(QEMUFile *f, void *pv, size_t unused_size,
> +                     const VMStateField *field, QJSON *vmdesc)
> +{
> +    bool direct_key = (!field->start);
> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[0];
> +    const VMStateDescription *val_vmsd = direct_key ? &field->vmsd[0] :
> +                                                      &field->vmsd[1];
> +    struct put_gtree_data capsule = {f, key_vmsd, val_vmsd, 0};
> +    GTree **pval = pv;
> +    GTree *tree = *pval;
> +    int ret;
> +
> +    qemu_put_be32(f, g_tree_nnodes(tree));
> +    g_tree_foreach(tree, put_gtree_elem, (gpointer)&capsule);
> +    qemu_put_byte(f, false);
> +    ret = capsule.ret;
> +    if (ret) {
> +        error_report("%s : failed to save gtree (%d)", field->name, ret);
> +    }
> +    return ret;
> +}
> +
> +static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
> +                     const VMStateField *field)
> +{
> +    bool direct_key = (!field->start);
> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[0];
> +    const VMStateDescription *val_vmsd = direct_key ? &field->vmsd[0] :
> +                                                      &field->vmsd[1];
> +    int version_id = field->version_id;
> +    size_t key_size = field->start;
> +    size_t val_size = field->size;
> +    int nnodes, count = 0;
> +    GTree **pval = pv;
> +    GTree *tree = *pval;
> +    void *key, *val;
> +    int ret = 0;
> +
> +    /* in case of direct key, the key vmsd can be {}, ie. check fields */
> +    if (!direct_key && version_id > key_vmsd->version_id) {
> +        error_report("%s %s",  key_vmsd->name, "too new");
> +        return -EINVAL;
> +    }
> +    if (!direct_key && version_id < key_vmsd->minimum_version_id) {
> +        error_report("%s %s",  key_vmsd->name, "too old");
> +        return -EINVAL;
> +    }
> +    if (version_id > val_vmsd->version_id) {
> +        error_report("%s %s",  val_vmsd->name, "too new");
> +        return -EINVAL;
> +    }
> +    if (version_id < val_vmsd->minimum_version_id) {
> +        error_report("%s %s",  val_vmsd->name, "too old");
> +        return -EINVAL;
> +    }
> +
> +    nnodes = qemu_get_be32(f);
> +
> +    while (qemu_get_byte(f)) {
> +        if ((++count) > nnodes) {
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (direct_key) {
> +            key = GUINT_TO_POINTER(qemu_get_be32(f));
> +        } else {
> +            key = g_malloc0(key_size);
> +            ret = vmstate_load_state(f, key_vmsd, key, version_id);
> +            if (ret) {
> +                error_report("%s : failed to load %s (%d)",
> +                             field->name, key_vmsd->name, ret);
> +                g_free(key);
> +                return ret;
> +            }
> +        }
> +        val = g_malloc0(val_size);
> +        ret = vmstate_load_state(f, val_vmsd, val, version_id);
> +        if (ret) {
> +            error_report("%s : failed to load %s (%d)",
> +                         field->name, val_vmsd->name, ret);
> +            g_free(key);
> +            g_free(val);
> +            return ret;
> +        }
> +        g_tree_insert(tree, key, val);
> +    }
> +    if (count != nnodes) {
> +        error_report("%s inconsistent stream when loading the gtree",
> +                     field->name);
> +    }
> +    return ret;
> +}
> +
> +
> +const VMStateInfo vmstate_info_gtree = {
> +    .name = "gtree",
> +    .get  = get_gtree,
> +    .put  = put_gtree,
> +};
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index e80c4c6143..0a1d976a19 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -812,6 +812,423 @@ static void test_load_q(void)
>      qemu_fclose(fload);
>  }
>  
> +/* interval (key) */
> +typedef struct TestGTreeInterval {
> +    uint64_t low;
> +    uint64_t high;
> +} TestGTreeInterval;
> +
> +#define VMSTATE_INTERVAL                               \
> +{                                                      \
> +    .name = "interval",                                \
> +    .version_id = 1,                                   \
> +    .minimum_version_id = 1,                           \
> +    .fields = (VMStateField[]) {                       \
> +        VMSTATE_UINT64(low, TestGTreeInterval),        \
> +        VMSTATE_UINT64(high, TestGTreeInterval),       \
> +        VMSTATE_END_OF_LIST()                          \
> +    }                                                  \
> +}
> +
> +/* mapping (value) */
> +typedef struct TestGTreeMapping {
> +    uint64_t phys_addr;
> +    uint32_t flags;
> +} TestGTreeMapping;
> +
> +#define VMSTATE_MAPPING                               \
> +{                                                     \
> +    .name = "mapping",                                \
> +    .version_id = 1,                                  \
> +    .minimum_version_id = 1,                          \
> +    .fields = (VMStateField[]) {                      \
> +        VMSTATE_UINT64(phys_addr, TestGTreeMapping),  \
> +        VMSTATE_UINT32(flags, TestGTreeMapping),      \
> +        VMSTATE_END_OF_LIST()                         \
> +    },                                                \
> +}
> +
> +static const VMStateDescription vmstate_interval_mapping[2] = {
> +    VMSTATE_INTERVAL, /* key   */
> +    VMSTATE_MAPPING   /* value */
> +};
> +
> +typedef struct TestGTreeDomain {
> +    int32_t  id;
> +    GTree    *mappings;
> +} TestGTreeDomain;
> +
> +typedef struct TestGTreeIOMMU {
> +    int32_t  id;
> +    GTree    *domains;
> +} TestGTreeIOMMU;
> +
> +/* Interval comparison function */
> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
> +{
> +    TestGTreeInterval *inta = (TestGTreeInterval *)a;
> +    TestGTreeInterval *intb = (TestGTreeInterval *)b;
> +
> +    if (inta->high < intb->low) {
> +        return -1;
> +    } else if (intb->high < inta->low) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +/* ID comparison function */
> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
> +{
> +    uint ua = GPOINTER_TO_UINT(a);
> +    uint ub = GPOINTER_TO_UINT(b);
> +    return (ua > ub) - (ua < ub);
> +}
> +
> +static void destroy_domain(gpointer data)
> +{
> +    TestGTreeDomain *domain = (TestGTreeDomain *)data;
> +
> +    g_tree_destroy(domain->mappings);
> +    g_free(domain);
> +}
> +
> +static int domain_preload(void *opaque)
> +{
> +    TestGTreeDomain *domain = opaque;
> +
> +    domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                       NULL, g_free, g_free);
> +    return 0;
> +}
> +
> +static int iommu_preload(void *opaque)
> +{
> +    TestGTreeIOMMU *iommu = opaque;
> +
> +    iommu->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                     NULL, NULL, destroy_domain);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_domain = {
> +    .name = "domain",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = domain_preload,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(id, TestGTreeDomain),
> +        VMSTATE_GTREE_V(mappings, TestGTreeDomain, 1,
> +                        vmstate_interval_mapping,
> +                        TestGTreeInterval, TestGTreeMapping),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_iommu = {
> +    .name = "iommu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_load = iommu_preload,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(id, TestGTreeIOMMU),
> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
> +                                   &vmstate_domain, TestGTreeDomain),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +uint8_t first_domain_dump[] = {
> +    /* id */
> +    0x00, 0x0, 0x0, 0x6,
> +    0x00, 0x0, 0x0, 0x2, /* 2 mappings */
> +    0x1, /* start of a */
> +    /* a */
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
> +    /* map_a */
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
> +    0x00, 0x00, 0x00, 0x01,
> +    0x1, /* start of b */
> +    /* b */
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
> +    /* map_b */
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x02,
> +    0x0, /* end of gtree */
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
> +};
> +
> +static TestGTreeDomain *create_first_domain(void)
> +{
> +    TestGTreeDomain *domain;
> +    TestGTreeMapping *map_a, *map_b;
> +    TestGTreeInterval *a, *b;
> +
> +    domain = g_malloc0(sizeof(TestGTreeDomain));
> +    domain->id = 6;
> +
> +    a = g_malloc0(sizeof(TestGTreeInterval));
> +    a->low = 0x1000;
> +    a->high = 0x1FFF;
> +
> +    b = g_malloc0(sizeof(TestGTreeInterval));
> +    b->low = 0x4000;
> +    b->high = 0x4FFF;
> +
> +    map_a = g_malloc0(sizeof(TestGTreeMapping));
> +    map_a->phys_addr = 0xa000;
> +    map_a->flags = 1;
> +
> +    map_b = g_malloc0(sizeof(TestGTreeMapping));
> +    map_b->phys_addr = 0xe0000;
> +    map_b->flags = 2;
> +
> +    domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp, NULL,
> +                                        (GDestroyNotify)g_free,
> +                                        (GDestroyNotify)g_free);
> +    g_tree_insert(domain->mappings, a, map_a);
> +    g_tree_insert(domain->mappings, b, map_b);
> +    return domain;
> +}
> +
> +static void test_gtree_save_domain(void)
> +{
> +    TestGTreeDomain *first_domain = create_first_domain();
> +
> +    save_vmstate(&vmstate_domain, first_domain);
> +    compare_vmstate(first_domain_dump, sizeof(first_domain_dump));
> +    destroy_domain(first_domain);
> +}
> +
> +struct match_node_data {
> +    GTree *tree;
> +    gpointer key;
> +    gpointer value;
> +};
> +
> +struct tree_cmp_data {
> +    GTree *tree1;
> +    GTree *tree2;
> +    GTraverseFunc match_node;
> +};
> +
> +static gboolean match_interval_mapping_node(gpointer key,
> +                                            gpointer value, gpointer data)
> +{
> +    TestGTreeMapping *map_a, *map_b;
> +    TestGTreeInterval *a, *b;
> +    struct match_node_data *d = (struct match_node_data *)data;
> +    char *str = g_strdup_printf("dest");
> +
> +    g_free(str);
> +    a = (TestGTreeInterval *)key;
> +    b = (TestGTreeInterval *)d->key;
> +
> +    map_a = (TestGTreeMapping *)value;
> +    map_b = (TestGTreeMapping *)d->value;
> +
> +    assert(a->low == b->low);
> +    assert(a->high == b->high);
> +    assert(map_a->phys_addr == map_b->phys_addr);
> +    assert(map_a->flags == map_b->flags);
> +    g_tree_remove(d->tree, key);
> +    return true;
> +}
> +
> +static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
> +{
> +    struct tree_cmp_data *tp = (struct tree_cmp_data *)data;
> +    struct match_node_data d = {tp->tree2, key, value};
> +
> +    g_tree_foreach(tp->tree2, tp->match_node, &d);
> +    g_tree_remove(tp->tree1, key);
> +    return false;
> +}
> +
> +static void compare_trees(GTree *tree1, GTree *tree2,
> +                          GTraverseFunc function)
> +{
> +    struct tree_cmp_data tp = {tree1, tree2, function};
> +
> +    g_tree_foreach(tree1, diff_tree, &tp);
> +    assert(g_tree_nnodes(tree1) == 0);
> +    assert(g_tree_nnodes(tree2) == 0);
> +}
> +
> +static void diff_domain(TestGTreeDomain *d1, TestGTreeDomain *d2)
> +{
> +    assert(d1->id == d2->id);
> +    compare_trees(d1->mappings, d2->mappings, match_interval_mapping_node);
> +}
> +
> +static gboolean match_domain_node(gpointer key, gpointer value, gpointer data)
> +{
> +    uint64_t id1, id2;
> +    TestGTreeDomain *d1, *d2;
> +    struct match_node_data *d = (struct match_node_data *)data;
> +
> +    id1 = (uint64_t)key;
> +    id2 = (uint64_t)d->key;
> +    d1 = (TestGTreeDomain *)value;
> +    d2 = (TestGTreeDomain *)d->value;
> +    assert(id1 == id2);
> +    diff_domain(d1, d2);
> +    g_tree_remove(d->tree, key);
> +    return true;
> +}
> +
> +static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
> +{
> +    assert(iommu1->id == iommu2->id);
> +    compare_trees(iommu1->domains, iommu2->domains, match_domain_node);
> +}
> +
> +static void test_gtree_load_domain(void)
> +{
> +    TestGTreeDomain *dest_domain = g_malloc0(sizeof(TestGTreeDomain));
> +    TestGTreeDomain *orig_domain = create_first_domain();
> +    QEMUFile *fload, *fsave;
> +    char eof;
> +
> +    fsave = open_test_file(true);
> +    qemu_put_buffer(fsave, first_domain_dump, sizeof(first_domain_dump));
> +    g_assert(!qemu_file_get_error(fsave));
> +    qemu_fclose(fsave);
> +
> +    fload = open_test_file(false);
> +
> +    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
> +    eof = qemu_get_byte(fload);
> +    g_assert(!qemu_file_get_error(fload));
> +    g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
> +
> +    diff_domain(orig_domain, dest_domain);
> +    destroy_domain(orig_domain);
> +    destroy_domain(dest_domain);
> +    qemu_fclose(fload);
> +}
> +
> +uint8_t iommu_dump[] = {
> +    /* iommu id */
> +    0x00, 0x0, 0x0, 0x7,
> +    0x00, 0x0, 0x0, 0x2, /* 2 domains */
> +    0x1,/* start of domain 5 */
> +        0x00, 0x0, 0x0, 0x5, /* key = 5 */
> +        0x00, 0x0, 0x0, 0x5, /* domain1 id */
> +        0x00, 0x0, 0x0, 0x1, /* 1 mapping */
> +        0x1, /* start of mappings */
> +            /* c */
> +            0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
> +            0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xFF, 0xFF,
> +            /* map_c */
> +            0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
> +            0x00, 0x0, 0x0, 0x3,
> +            0x0, /* end of domain1 mappings*/
> +    0x1,/* start of domain 6 */
> +        0x00, 0x0, 0x0, 0x6, /* key = 6 */
> +        0x00, 0x0, 0x0, 0x6, /* domain6 id */
> +            0x00, 0x0, 0x0, 0x2, /* 2 mappings */
> +            0x1, /* start of a */
> +            /* a */
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0xFF,
> +            /* map_a */
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa0, 0x00,
> +            0x00, 0x00, 0x00, 0x01,
> +            0x1, /* start of b */
> +            /* b */
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4F, 0xFF,
> +            /* map_b */
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x00, 0x00,
> +            0x00, 0x00, 0x00, 0x02,
> +            0x0, /* end of domain6 mappings*/
> +    0x0, /* end of domains */
> +    QEMU_VM_EOF, /* just to ensure we won't get EOF reported prematurely */
> +};
> +
> +static TestGTreeIOMMU *create_iommu(void)
> +{
> +    TestGTreeIOMMU *iommu = g_malloc0(sizeof(TestGTreeIOMMU));
> +    TestGTreeDomain *first_domain = create_first_domain();
> +    TestGTreeDomain *second_domain;
> +    TestGTreeMapping *map_c;
> +    TestGTreeInterval *c;
> +
> +    iommu->id = 7;
> +    iommu->domains = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
> +                                     NULL,
> +                                     destroy_domain);
> +
> +    second_domain = g_malloc0(sizeof(TestGTreeDomain));
> +    second_domain->id = 5;
> +    second_domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                              NULL,
> +                                              (GDestroyNotify)g_free,
> +                                              (GDestroyNotify)g_free);
> +
> +    g_tree_insert(iommu->domains, GUINT_TO_POINTER(6), first_domain);
> +    g_tree_insert(iommu->domains, GUINT_TO_POINTER(5), second_domain);
> +
> +    c = g_malloc0(sizeof(TestGTreeInterval));
> +    c->low = 0x1000000;
> +    c->high = 0x1FFFFFF;
> +
> +    map_c = g_malloc0(sizeof(TestGTreeMapping));
> +    map_c->phys_addr = 0xF000000;
> +    map_c->flags = 0x3;
> +
> +    g_tree_insert(second_domain->mappings, c, map_c);
> +    return iommu;
> +}
> +
> +static void destroy_iommu(TestGTreeIOMMU *iommu)
> +{
> +    g_tree_destroy(iommu->domains);
> +    g_free(iommu);
> +}
> +
> +static void test_gtree_save_iommu(void)
> +{
> +    TestGTreeIOMMU *iommu = create_iommu();
> +
> +    save_vmstate(&vmstate_iommu, iommu);
> +    compare_vmstate(iommu_dump, sizeof(iommu_dump));
> +    destroy_iommu(iommu);
> +}
> +
> +static void test_gtree_load_iommu(void)
> +{
> +    TestGTreeIOMMU *dest_iommu = g_malloc0(sizeof(TestGTreeIOMMU));
> +    TestGTreeIOMMU *orig_iommu = create_iommu();
> +    QEMUFile *fsave, *fload;
> +    char eof;
> +    int ret;
> +
> +    fsave = open_test_file(true);
> +    qemu_put_buffer(fsave, iommu_dump, sizeof(iommu_dump));
> +    g_assert(!qemu_file_get_error(fsave));
> +    qemu_fclose(fsave);
> +
> +    fload = open_test_file(false);
> +    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
> +    ret = qemu_file_get_error(fload);
> +    eof = qemu_get_byte(fload);
> +    ret = qemu_file_get_error(fload);
> +    g_assert(!ret);
> +    g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
> +    g_assert_cmpint(eof, ==, QEMU_VM_EOF);
> +
> +    diff_iommu(orig_iommu, dest_iommu);
> +    destroy_iommu(orig_iommu);
> +    destroy_iommu(dest_iommu);
> +    qemu_fclose(fload);
> +}
> +
>  typedef struct TmpTestStruct {
>      TestStruct *parent;
>      int64_t diff;
> @@ -932,6 +1349,10 @@ int main(int argc, char **argv)
>                      test_arr_ptr_prim_0_load);
>      g_test_add_func("/vmstate/qtailq/save/saveq", test_save_q);
>      g_test_add_func("/vmstate/qtailq/load/loadq", test_load_q);
> +    g_test_add_func("/vmstate/gtree/save/savedomain", test_gtree_save_domain);
> +    g_test_add_func("/vmstate/gtree/load/loaddomain", test_gtree_load_domain);
> +    g_test_add_func("/vmstate/gtree/save/saveiommu", test_gtree_save_iommu);
> +    g_test_add_func("/vmstate/gtree/load/loadiommu", test_gtree_load_iommu);
>      g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
>      g_test_run();
>  
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

