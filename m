Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F98320782
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qIcuHzaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F98320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGiW-0002YJ-Gj
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kYGgm-0001aE-OF; Thu, 29 Oct 2020 18:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kYGgh-0003Ui-IT; Thu, 29 Oct 2020 18:46:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09TMXhhn102165; Thu, 29 Oct 2020 18:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H5v2xbpUrIS62JTvcWDgh+WcyuhKWQ3SLSJiiDe33FM=;
 b=qIcuHzaS5mt2x8uJWMdFgUQlgySIC2e2IAWmb1CgO7a6vq4UsMxDfzYUOl60IfMvx41H
 tsg9tQLF9TAdi5/0yMIy+NVhcOt7ncw6XzIAH3L26hOV8C3BFW6fNODICJMsKEe6XfLQ
 HhkhYRBgZHftHw9vGrdisxKprHeA4ARPmVwuCoZfMqtWWWs7jSnl1sPKrYxZq1UHmvIf
 ahSN9lqGf9XRash7FEIkhMhT6RByoTeNltRXpdvrpsaLANbd9BLVh3bzfTLyJQpEteHD
 CEfS3DfYOz4AzCkgrLs0RebbARB80CLiEDF1MSynrvx0aaT9UQ+s8cLUYgop/lG9a219 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34g31cxyn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 18:46:23 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09TMgPZK130876;
 Thu, 29 Oct 2020 18:46:23 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34g31cxymp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 18:46:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TMfO2Z000644;
 Thu, 29 Oct 2020 22:46:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01dal.us.ibm.com with ESMTP id 34cbw9r3as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2020 22:46:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09TMkKwF46793124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2020 22:46:20 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 496FC78064;
 Thu, 29 Oct 2020 22:46:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A66978067;
 Thu, 29 Oct 2020 22:46:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2020 22:46:18 +0000 (GMT)
Subject: Re: [PATCH 09/36] qdev: Make qdev_get_prop_ptr() get Object* arg
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-10-ehabkost@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <620fbb37-fe1d-36d0-e216-b8cde61954cb@linux.ibm.com>
Date: Thu, 29 Oct 2020 18:46:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201029220246.472693-10-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-29_12:2020-10-29,
 2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 clxscore=1015 suspectscore=2 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 18:46:29
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 6:02 PM, Eduardo Habkost wrote:
> Make the code more generic and not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by:  Stefan Berger <stefanb@linux.ibm.com>
> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-s390x@nongnu.org
> ---
>   include/hw/qdev-properties.h     |  2 +-
>   backends/tpm/tpm_util.c          |  8 ++--
>   hw/block/xen-block.c             |  6 +--
>   hw/core/qdev-properties-system.c | 57 +++++++++-------------
>   hw/core/qdev-properties.c        | 82 +++++++++++++-------------------
>   hw/s390x/css.c                   |  5 +-
>   hw/s390x/s390-pci-bus.c          |  4 +-
>   hw/vfio/pci-quirks.c             |  5 +-
>   8 files changed, 68 insertions(+), 101 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 0ea822e6a7..0b92cfc761 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -302,7 +302,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>                              const uint8_t *value);
>   void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>
> -void *qdev_get_prop_ptr(DeviceState *dev, Property *prop);
> +void *qdev_get_prop_ptr(Object *obj, Property *prop);
>
>   void qdev_prop_register_global(GlobalProperty *prop);
>   const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index b58d298c1a..e91c21dd4a 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -35,8 +35,7 @@
>   static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>                       Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
> -    TPMBackend **be = qdev_get_prop_ptr(dev, opaque);
> +    TPMBackend **be = qdev_get_prop_ptr(obj, opaque);
>       char *p;
>
>       p = g_strdup(*be ? (*be)->id : "");
> @@ -49,7 +48,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    TPMBackend *s, **be = qdev_get_prop_ptr(dev, prop);
> +    TPMBackend *s, **be = qdev_get_prop_ptr(obj, prop);
>       char *str;
>
>       if (dev->realized) {
> @@ -73,9 +72,8 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
>
>   static void release_tpm(Object *obj, const char *name, void *opaque)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    TPMBackend **be = qdev_get_prop_ptr(dev, prop);
> +    TPMBackend **be = qdev_get_prop_ptr(obj, prop);
>
>       if (*be) {
>           tpm_backend_reset(*be);
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 8a7a3f5452..1ba9981c08 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -335,9 +335,8 @@ static char *disk_to_vbd_name(unsigned int disk)
>   static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
> +    XenBlockVdev *vdev = qdev_get_prop_ptr(obj, prop);
>       char *str;
>
>       switch (vdev->type) {
> @@ -396,9 +395,8 @@ static int vbd_name_to_disk(const char *name, const char **endp,
>   static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
>                                  void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
> +    XenBlockVdev *vdev = qdev_get_prop_ptr(obj, prop);
>       char *str, *p;
>       const char *end;
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index d0fb063a49..c8c73c371b 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -59,9 +59,8 @@ static bool check_prop_still_unset(DeviceState *dev, const char *name,
>   static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
>                         Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    void **ptr = qdev_get_prop_ptr(dev, prop);
> +    void **ptr = qdev_get_prop_ptr(obj, prop);
>       const char *value;
>       char *p;
>
> @@ -87,7 +86,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    void **ptr = qdev_get_prop_ptr(dev, prop);
> +    void **ptr = qdev_get_prop_ptr(obj, prop);
>       char *str;
>       BlockBackend *blk;
>       bool blk_created = false;
> @@ -185,7 +184,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    BlockBackend **ptr = qdev_get_prop_ptr(dev, prop);
> +    BlockBackend **ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (*ptr) {
>           AioContext *ctx = blk_get_aio_context(*ptr);
> @@ -218,8 +217,7 @@ const PropertyInfo qdev_prop_drive_iothread = {
>   static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>                       Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
> -    CharBackend *be = qdev_get_prop_ptr(dev, opaque);
> +    CharBackend *be = qdev_get_prop_ptr(obj, opaque);
>       char *p;
>
>       p = g_strdup(be->chr && be->chr->label ? be->chr->label : "");
> @@ -232,7 +230,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    CharBackend *be = qdev_get_prop_ptr(dev, prop);
> +    CharBackend *be = qdev_get_prop_ptr(obj, prop);
>       Chardev *s;
>       char *str;
>
> @@ -272,9 +270,8 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
>
>   static void release_chr(Object *obj, const char *name, void *opaque)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    CharBackend *be = qdev_get_prop_ptr(dev, prop);
> +    CharBackend *be = qdev_get_prop_ptr(obj, prop);
>
>       qemu_chr_fe_deinit(be, false);
>   }
> @@ -297,9 +294,8 @@ const PropertyInfo qdev_prop_chr = {
>   static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
>                       Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
> +    MACAddr *mac = qdev_get_prop_ptr(obj, prop);
>       char buffer[2 * 6 + 5 + 1];
>       char *p = buffer;
>
> @@ -315,7 +311,7 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    MACAddr *mac = qdev_get_prop_ptr(dev, prop);
> +    MACAddr *mac = qdev_get_prop_ptr(obj, prop);
>       int i, pos;
>       char *str;
>       const char *p;
> @@ -381,9 +377,8 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>   static void get_netdev(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
> +    NICPeers *peers_ptr = qdev_get_prop_ptr(obj, prop);
>       char *p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
>
>       visit_type_str(v, name, &p, errp);
> @@ -395,7 +390,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
> +    NICPeers *peers_ptr = qdev_get_prop_ptr(obj, prop);
>       NetClientState **ncs = peers_ptr->ncs;
>       NetClientState *peers[MAX_QUEUE_NUM];
>       int queues, err = 0, i = 0;
> @@ -461,9 +456,8 @@ const PropertyInfo qdev_prop_netdev = {
>   static void get_audiodev(Object *obj, Visitor *v, const char* name,
>                            void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
> +    QEMUSoundCard *card = qdev_get_prop_ptr(obj, prop);
>       char *p = g_strdup(audio_get_id(card));
>
>       visit_type_str(v, name, &p, errp);
> @@ -475,7 +469,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
> +    QEMUSoundCard *card = qdev_get_prop_ptr(obj, prop);
>       AudioState *state;
>       int err = 0;
>       char *str;
> @@ -582,7 +576,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>       uint64_t value;
>       Error *local_err = NULL;
>
> @@ -674,9 +668,8 @@ const PropertyInfo qdev_prop_multifd_compression = {
>   static void get_reserved_region(Object *obj, Visitor *v, const char *name,
>                                   void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
> +    ReservedRegion *rr = qdev_get_prop_ptr(obj, prop);
>       char buffer[64];
>       char *p = buffer;
>       int rc;
> @@ -693,7 +686,7 @@ static void set_reserved_region(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    ReservedRegion *rr = qdev_get_prop_ptr(dev, prop);
> +    ReservedRegion *rr = qdev_get_prop_ptr(obj, prop);
>       Error *local_err = NULL;
>       const char *endptr;
>       char *str;
> @@ -761,7 +754,7 @@ static void set_pci_devfn(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int32_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> +    int32_t value, *ptr = qdev_get_prop_ptr(obj, prop);
>       unsigned int slot, fn, n;
>       char *str;
>
> @@ -804,8 +797,7 @@ invalid:
>   static int print_pci_devfn(Object *obj, Property *prop, char *dest,
>                              size_t len)
>   {
> -    DeviceState *dev = DEVICE(obj);
> -    int32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (*ptr == -1) {
>           return snprintf(dest, len, "<unset>");
> @@ -828,9 +820,8 @@ const PropertyInfo qdev_prop_pci_devfn = {
>   static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
> +    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(obj, prop);
>       char buffer[] = "ffff:ff:ff.f";
>       char *p = buffer;
>       int rc = 0;
> @@ -857,7 +848,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
> +    PCIHostDeviceAddress *addr = qdev_get_prop_ptr(obj, prop);
>       char *str, *p;
>       const char *e;
>       unsigned long val;
> @@ -950,9 +941,8 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
>   static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(obj, prop);
>       int speed;
>
>       switch (*p) {
> @@ -981,7 +971,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
> +    PCIExpLinkSpeed *p = qdev_get_prop_ptr(obj, prop);
>       int speed;
>
>       if (dev->realized) {
> @@ -1027,9 +1017,8 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
>   static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(obj, prop);
>       int width;
>
>       switch (*p) {
> @@ -1067,7 +1056,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
> +    PCIExpLinkWidth *p = qdev_get_prop_ptr(obj, prop);
>       int width;
>
>       if (dev->realized) {
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 3a4638f4de..0a54a922c8 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -38,9 +38,9 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
>       }
>   }
>
> -void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
> +void *qdev_get_prop_ptr(Object *obj, Property *prop)
>   {
> -    void *ptr = dev;
> +    void *ptr = obj;
>       ptr += prop->offset;
>       return ptr;
>   }
> @@ -48,9 +48,8 @@ void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
>   void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int *ptr = qdev_get_prop_ptr(dev, prop);
> +    int *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>   }
> @@ -60,7 +59,7 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int *ptr = qdev_get_prop_ptr(dev, prop);
> +    int *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -94,8 +93,7 @@ static uint32_t qdev_get_prop_mask(Property *prop)
>
>   static void bit_prop_set(Object *obj, Property *props, bool val)
>   {
> -    DeviceState *dev = DEVICE(obj);
> -    uint32_t *p = qdev_get_prop_ptr(dev, props);
> +    uint32_t *p = qdev_get_prop_ptr(obj, props);
>       uint32_t mask = qdev_get_prop_mask(props);
>       if (val) {
>           *p |= mask;
> @@ -107,9 +105,8 @@ static void bit_prop_set(Object *obj, Property *props, bool val)
>   static void prop_get_bit(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *p = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *p = qdev_get_prop_ptr(obj, prop);
>       bool value = (*p & qdev_get_prop_mask(prop)) != 0;
>
>       visit_type_bool(v, name, &value, errp);
> @@ -156,8 +153,7 @@ static uint64_t qdev_get_prop_mask64(Property *prop)
>
>   static void bit64_prop_set(Object *obj, Property *props, bool val)
>   {
> -    DeviceState *dev = DEVICE(obj);
> -    uint64_t *p = qdev_get_prop_ptr(dev, props);
> +    uint64_t *p = qdev_get_prop_ptr(obj, props);
>       uint64_t mask = qdev_get_prop_mask64(props);
>       if (val) {
>           *p |= mask;
> @@ -169,9 +165,8 @@ static void bit64_prop_set(Object *obj, Property *props, bool val)
>   static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
>                              void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint64_t *p = qdev_get_prop_ptr(dev, prop);
> +    uint64_t *p = qdev_get_prop_ptr(obj, prop);
>       bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
>
>       visit_type_bool(v, name, &value, errp);
> @@ -208,9 +203,8 @@ const PropertyInfo qdev_prop_bit64 = {
>   static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
>                        Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    bool *ptr = qdev_get_prop_ptr(dev, prop);
> +    bool *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_bool(v, name, ptr, errp);
>   }
> @@ -220,7 +214,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    bool *ptr = qdev_get_prop_ptr(dev, prop);
> +    bool *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -242,9 +236,8 @@ const PropertyInfo qdev_prop_bool = {
>   static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
>                         Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint8(v, name, ptr, errp);
>   }
> @@ -254,7 +247,7 @@ static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -288,9 +281,8 @@ const PropertyInfo qdev_prop_uint8 = {
>   void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint16_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint16_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint16(v, name, ptr, errp);
>   }
> @@ -300,7 +292,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint16_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint16_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -322,9 +314,8 @@ const PropertyInfo qdev_prop_uint16 = {
>   static void get_uint32(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint32(v, name, ptr, errp);
>   }
> @@ -334,7 +325,7 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -347,9 +338,8 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
>   void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_int32(v, name, ptr, errp);
>   }
> @@ -359,7 +349,7 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    int32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -388,9 +378,8 @@ const PropertyInfo qdev_prop_int32 = {
>   static void get_uint64(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint64(v, name, ptr, errp);
>   }
> @@ -400,7 +389,7 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -413,9 +402,8 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
>   static void get_int64(Object *obj, Visitor *v, const char *name,
>                         void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    int64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_int64(v, name, ptr, errp);
>   }
> @@ -425,7 +413,7 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    int64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    int64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> @@ -454,15 +442,14 @@ const PropertyInfo qdev_prop_int64 = {
>   static void release_string(Object *obj, const char *name, void *opaque)
>   {
>       Property *prop = opaque;
> -    g_free(*(char **)qdev_get_prop_ptr(DEVICE(obj), prop));
> +    g_free(*(char **)qdev_get_prop_ptr(obj, prop));
>   }
>
>   static void get_string(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    char **ptr = qdev_get_prop_ptr(dev, prop);
> +    char **ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (!*ptr) {
>           char *str = (char *)"";
> @@ -477,7 +464,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    char **ptr = qdev_get_prop_ptr(dev, prop);
> +    char **ptr = qdev_get_prop_ptr(obj, prop);
>       char *str;
>
>       if (dev->realized) {
> @@ -515,9 +502,8 @@ const PropertyInfo qdev_prop_on_off_auto = {
>   void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>       uint64_t value = *ptr;
>
>       visit_type_size(v, name, &value, errp);
> @@ -528,7 +514,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>       uint64_t value;
>
>       if (dev->realized) {
> @@ -563,9 +549,8 @@ const PropertyInfo qdev_prop_size32 = {
>   static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
>                        Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    QemuUUID *uuid = qdev_get_prop_ptr(dev, prop);
> +    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
>       char buffer[UUID_FMT_LEN + 1];
>       char *p = buffer;
>
> @@ -581,7 +566,7 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    QemuUUID *uuid = qdev_get_prop_ptr(dev, prop);
> +    QemuUUID *uuid = qdev_get_prop_ptr(obj, prop);
>       char *str;
>
>       if (dev->realized) {
> @@ -653,7 +638,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
>        */
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *alenptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *alenptr = qdev_get_prop_ptr(obj, prop);
>       void **arrayptr = (void *)dev + prop->arrayoffset;
>       void *eltptr;
>       const char *arrayname;
> @@ -699,7 +684,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
>            * being inside the device struct.
>            */
>           arrayprop->prop.offset = eltptr - (void *)dev;
> -        assert(qdev_get_prop_ptr(dev, &arrayprop->prop) == eltptr);
> +        assert(qdev_get_prop_ptr(obj, &arrayprop->prop) == eltptr);
>           object_property_add(obj, propname,
>                               arrayprop->prop.info->name,
>                               arrayprop->prop.info->get,
> @@ -893,9 +878,8 @@ void qdev_prop_set_globals(DeviceState *dev)
>   static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
>                        Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_size(v, name, ptr, errp);
>   }
> @@ -905,7 +889,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint64_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 9961cfe7bf..2b8f33fec2 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -2343,9 +2343,8 @@ void css_reset(void)
>   static void get_css_devid(Object *obj, Visitor *v, const char *name,
>                             void *opaque, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    CssDevId *dev_id = qdev_get_prop_ptr(dev, prop);
> +    CssDevId *dev_id = qdev_get_prop_ptr(obj, prop);
>       char buffer[] = "xx.x.xxxx";
>       char *p = buffer;
>       int r;
> @@ -2375,7 +2374,7 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    CssDevId *dev_id = qdev_get_prop_ptr(dev, prop);
> +    CssDevId *dev_id = qdev_get_prop_ptr(obj, prop);
>       char *str;
>       int num, n1, n2;
>       unsigned int cssid, ssid, devid;
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index fb4cee87a4..b59cf0651a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1248,7 +1248,7 @@ static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>   {
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(DEVICE(obj), prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint32(v, name, ptr, errp);
>   }
> @@ -1259,7 +1259,7 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
>       DeviceState *dev = DEVICE(obj);
>       S390PCIBusDevice *zpci = S390_PCI_DEVICE(obj);
>       Property *prop = opaque;
> -    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint32_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 57150913b7..53569925a2 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1488,9 +1488,8 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>                                          const char *name, void *opaque,
>                                          Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint8_t *ptr = qdev_get_prop_ptr(obj, prop);
>
>       visit_type_uint8(v, name, ptr, errp);
>   }
> @@ -1501,7 +1500,7 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
>   {
>       DeviceState *dev = DEVICE(obj);
>       Property *prop = opaque;
> -    uint8_t value, *ptr = qdev_get_prop_ptr(dev, prop);
> +    uint8_t value, *ptr = qdev_get_prop_ptr(obj, prop);
>
>       if (dev->realized) {
>           qdev_prop_set_after_realize(dev, name, errp);



