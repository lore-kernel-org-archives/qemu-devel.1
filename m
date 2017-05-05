Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8c-00016E-0E
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8Z-0005LN-Ca
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8Z-0005Ko-4g
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXnpb023806
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:26 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8v0pw9m9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:25 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:23 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:04 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-8-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/10] s390x/css: remove unused
 subch_dev_(load|save)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Since the functions subch_dev_load and subch_dev save are not used
any more let's remove them.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 143 -------------------------------------------------
 include/hw/s390x/css.h |   2 -
 2 files changed, 145 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 2bda7d0..94338b2 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1914,149 +1914,6 @@ int css_enable_mss(void)
     return 0;
 }
 
-void subch_device_save(SubchDev *s, QEMUFile *f)
-{
-    int i;
-
-    qemu_put_byte(f, s->cssid);
-    qemu_put_byte(f, s->ssid);
-    qemu_put_be16(f, s->schid);
-    qemu_put_be16(f, s->devno);
-    qemu_put_byte(f, s->thinint_active);
-    /* SCHIB */
-    /*     PMCW */
-    qemu_put_be32(f, s->curr_status.pmcw.intparm);
-    qemu_put_be16(f, s->curr_status.pmcw.flags);
-    qemu_put_be16(f, s->curr_status.pmcw.devno);
-    qemu_put_byte(f, s->curr_status.pmcw.lpm);
-    qemu_put_byte(f, s->curr_status.pmcw.pnom);
-    qemu_put_byte(f, s->curr_status.pmcw.lpum);
-    qemu_put_byte(f, s->curr_status.pmcw.pim);
-    qemu_put_be16(f, s->curr_status.pmcw.mbi);
-    qemu_put_byte(f, s->curr_status.pmcw.pom);
-    qemu_put_byte(f, s->curr_status.pmcw.pam);
-    qemu_put_buffer(f, s->curr_status.pmcw.chpid, 8);
-    qemu_put_be32(f, s->curr_status.pmcw.chars);
-    /*     SCSW */
-    qemu_put_be16(f, s->curr_status.scsw.flags);
-    qemu_put_be16(f, s->curr_status.scsw.ctrl);
-    qemu_put_be32(f, s->curr_status.scsw.cpa);
-    qemu_put_byte(f, s->curr_status.scsw.dstat);
-    qemu_put_byte(f, s->curr_status.scsw.cstat);
-    qemu_put_be16(f, s->curr_status.scsw.count);
-    qemu_put_be64(f, s->curr_status.mba);
-    qemu_put_buffer(f, s->curr_status.mda, 4);
-    /* end SCHIB */
-    qemu_put_buffer(f, s->sense_data, 32);
-    qemu_put_be64(f, s->channel_prog);
-    /* last cmd */
-    qemu_put_byte(f, s->last_cmd.cmd_code);
-    qemu_put_byte(f, s->last_cmd.flags);
-    qemu_put_be16(f, s->last_cmd.count);
-    qemu_put_be32(f, s->last_cmd.cda);
-    qemu_put_byte(f, s->last_cmd_valid);
-    qemu_put_byte(f, s->id.reserved);
-    qemu_put_be16(f, s->id.cu_type);
-    qemu_put_byte(f, s->id.cu_model);
-    qemu_put_be16(f, s->id.dev_type);
-    qemu_put_byte(f, s->id.dev_model);
-    qemu_put_byte(f, s->id.unused);
-    for (i = 0; i < ARRAY_SIZE(s->id.ciw); i++) {
-        qemu_put_byte(f, s->id.ciw[i].type);
-        qemu_put_byte(f, s->id.ciw[i].command);
-        qemu_put_be16(f, s->id.ciw[i].count);
-    }
-    qemu_put_byte(f, s->ccw_fmt_1);
-    qemu_put_byte(f, s->ccw_no_data_cnt);
-}
-
-int subch_device_load(SubchDev *s, QEMUFile *f)
-{
-    SubchDev *old_s;
-    uint16_t old_schid = s->schid;
-    int i;
-
-    s->cssid = qemu_get_byte(f);
-    s->ssid = qemu_get_byte(f);
-    s->schid = qemu_get_be16(f);
-    s->devno = qemu_get_be16(f);
-    /* Re-assign subch. */
-    if (old_schid != s->schid) {
-        old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
-        /*
-         * (old_s != s) means that some other device has its correct
-         * subchannel already assigned (in load).
-         */
-        if (old_s == s) {
-            css_subch_assign(s->cssid, s->ssid, old_schid, s->devno, NULL);
-        }
-        /* It's OK to re-assign without a prior de-assign. */
-        css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
-    }
-    s->thinint_active = qemu_get_byte(f);
-    /* SCHIB */
-    /*     PMCW */
-    s->curr_status.pmcw.intparm = qemu_get_be32(f);
-    s->curr_status.pmcw.flags = qemu_get_be16(f);
-    s->curr_status.pmcw.devno = qemu_get_be16(f);
-    s->curr_status.pmcw.lpm = qemu_get_byte(f);
-    s->curr_status.pmcw.pnom  = qemu_get_byte(f);
-    s->curr_status.pmcw.lpum = qemu_get_byte(f);
-    s->curr_status.pmcw.pim = qemu_get_byte(f);
-    s->curr_status.pmcw.mbi = qemu_get_be16(f);
-    s->curr_status.pmcw.pom = qemu_get_byte(f);
-    s->curr_status.pmcw.pam = qemu_get_byte(f);
-    qemu_get_buffer(f, s->curr_status.pmcw.chpid, 8);
-    s->curr_status.pmcw.chars = qemu_get_be32(f);
-    /*     SCSW */
-    s->curr_status.scsw.flags = qemu_get_be16(f);
-    s->curr_status.scsw.ctrl = qemu_get_be16(f);
-    s->curr_status.scsw.cpa = qemu_get_be32(f);
-    s->curr_status.scsw.dstat = qemu_get_byte(f);
-    s->curr_status.scsw.cstat = qemu_get_byte(f);
-    s->curr_status.scsw.count = qemu_get_be16(f);
-    s->curr_status.mba = qemu_get_be64(f);
-    qemu_get_buffer(f, s->curr_status.mda, 4);
-    /* end SCHIB */
-    qemu_get_buffer(f, s->sense_data, 32);
-    s->channel_prog = qemu_get_be64(f);
-    /* last cmd */
-    s->last_cmd.cmd_code = qemu_get_byte(f);
-    s->last_cmd.flags = qemu_get_byte(f);
-    s->last_cmd.count = qemu_get_be16(f);
-    s->last_cmd.cda = qemu_get_be32(f);
-    s->last_cmd_valid = qemu_get_byte(f);
-    s->id.reserved = qemu_get_byte(f);
-    s->id.cu_type = qemu_get_be16(f);
-    s->id.cu_model = qemu_get_byte(f);
-    s->id.dev_type = qemu_get_be16(f);
-    s->id.dev_model = qemu_get_byte(f);
-    s->id.unused = qemu_get_byte(f);
-    for (i = 0; i < ARRAY_SIZE(s->id.ciw); i++) {
-        s->id.ciw[i].type = qemu_get_byte(f);
-        s->id.ciw[i].command = qemu_get_byte(f);
-        s->id.ciw[i].count = qemu_get_be16(f);
-    }
-    s->ccw_fmt_1 = qemu_get_byte(f);
-    s->ccw_no_data_cnt = qemu_get_byte(f);
-    /*
-     * Hack alert. We don't migrate the channel subsystem status (no
-     * device!), but we need to find out if the guest enabled mss/mcss-e.
-     * If the subchannel is enabled, it certainly was able to access it,
-     * so adjust the max_ssid/max_cssid values for relevant ssid/cssid
-     * values. This is not watertight, but better than nothing.
-     */
-    if (s->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA) {
-        if (s->ssid) {
-            channel_subsys.max_ssid = MAX_SSID;
-        }
-        if (s->cssid != channel_subsys.default_cssid) {
-            channel_subsys.max_cssid = MAX_CSSID;
-        }
-    }
-    return 0;
-}
-
 void css_reset_sch(SubchDev *sch)
 {
     PMCW *p = &sch->curr_status.pmcw;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 6a451b2..e67ac5c 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -116,8 +116,6 @@ int map_indicator(AdapterInfo *adapter, IndAddr *indicator);
 
 typedef SubchDev *(*css_subch_cb_func)(uint8_t m, uint8_t cssid, uint8_t ssid,
                                        uint16_t schid);
-void subch_device_save(SubchDev *s, QEMUFile *f);
-int subch_device_load(SubchDev *s, QEMUFile *f);
 int css_create_css_image(uint8_t cssid, bool default_image);
 bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
-- 
2.10.2
