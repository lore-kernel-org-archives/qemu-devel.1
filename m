Received: from eggs.gnu.org ([2001:4830:134:3::10]:41939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuIdX-00038I-Db
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuIdT-00055Y-7T
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:00:11 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:38874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuIdS-00052o-Qm
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:00:07 -0400
Received: from player799.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B61A0E4523
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 15:00:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  1 Apr 2017 14:57:57 +0200
Message-Id: <1491051477-10455-5-git-send-email-clg@kaod.org>
In-Reply-To: <1491051477-10455-1-git-send-email-clg@kaod.org>
References: <1491051477-10455-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] slirp: add a fake NC-SI backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

NC-SI (Network Controller Sideband Interface) enables a BMC to manage
a set of NICs on a system. This model takes the simplest approach and
reverses the NC-SI packets to pretend a NIC is present and exercise
the Linux driver.

The NCSI header file <ncsi-pkt.h> comes from mainline Linux and was
untabified.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/net/eth.h   |   1 +
 slirp/Makefile.objs |   2 +-
 slirp/ncsi-pkt.h    | 418 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 slirp/ncsi.c        |  78 ++++++++++
 slirp/slirp.c       |   4 +
 slirp/slirp.h       |   3 +
 6 files changed, 505 insertions(+), 1 deletion(-)
 create mode 100644 slirp/ncsi-pkt.h
 create mode 100644 slirp/ncsi.c

diff --git a/include/net/eth.h b/include/net/eth.h
index afeb45be34e1..09054a506d6e 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -209,6 +209,7 @@ struct tcp_hdr {
 #define ETH_P_IPV6                (0x86dd)
 #define ETH_P_VLAN                (0x8100)
 #define ETH_P_DVLAN               (0x88a8)
+#define ETH_P_NCSI                (0x88f8)
 #define ETH_P_UNKNOWN             (0xffff)
 #define VLAN_VID_MASK             0x0fff
 #define IP_HEADER_VERSION_4       (4)
diff --git a/slirp/Makefile.objs b/slirp/Makefile.objs
index 1baa1f1c7cfb..28049b03cddc 100644
--- a/slirp/Makefile.objs
+++ b/slirp/Makefile.objs
@@ -2,4 +2,4 @@ common-obj-y =3D cksum.o if.o ip_icmp.o ip6_icmp.o ip6_in=
put.o ip6_output.o \
                ip_input.o ip_output.o dnssearch.o dhcpv6.o
 common-obj-y +=3D slirp.o mbuf.o misc.o sbuf.o socket.o tcp_input.o tcp_=
output.o
 common-obj-y +=3D tcp_subr.o tcp_timer.o udp.o udp6.o bootp.o tftp.o arp=
_table.o \
-                ndp_table.o
+                ndp_table.o ncsi.o
diff --git a/slirp/ncsi-pkt.h b/slirp/ncsi-pkt.h
new file mode 100644
index 000000000000..cb786bba463e
--- /dev/null
+++ b/slirp/ncsi-pkt.h
@@ -0,0 +1,418 @@
+/*
+ * Copyright Gavin Shan, IBM Corporation 2016.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef NCSI_PKT_H
+#define NCSI_PKT_H
+
+#define __be32 uint32_t
+#define __be16 uint16_t
+
+struct ncsi_pkt_hdr {
+        unsigned char mc_id;        /* Management controller ID */
+        unsigned char revision;     /* NCSI version - 0x01      */
+        unsigned char reserved;     /* Reserved                 */
+        unsigned char id;           /* Packet sequence number   */
+        unsigned char type;         /* Packet type              */
+        unsigned char channel;      /* Network controller ID    */
+        __be16        length;       /* Payload length           */
+        __be32        reserved1[2]; /* Reserved                 */
+};
+
+struct ncsi_cmd_pkt_hdr {
+        struct ncsi_pkt_hdr common; /* Common NCSI packet header */
+};
+
+struct ncsi_rsp_pkt_hdr {
+        struct ncsi_pkt_hdr common; /* Common NCSI packet header */
+        __be16              code;   /* Response code             */
+        __be16              reason; /* Response reason           */
+};
+
+struct ncsi_aen_pkt_hdr {
+        struct ncsi_pkt_hdr common;       /* Common NCSI packet header *=
/
+        unsigned char       reserved2[3]; /* Reserved                  *=
/
+        unsigned char       type;         /* AEN packet type           *=
/
+};
+
+/* NCSI common command packet */
+struct ncsi_cmd_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header */
+        __be32                  checksum; /* Checksum       */
+        unsigned char           pad[26];
+};
+
+struct ncsi_rsp_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;      /* Response header */
+        __be32                  checksum; /* Checksum        */
+        unsigned char           pad[22];
+};
+
+/* Select Package */
+struct ncsi_cmd_sp_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;            /* Command header */
+        unsigned char           reserved[3];    /* Reserved       */
+        unsigned char           hw_arbitration; /* HW arbitration */
+        __be32                  checksum;       /* Checksum       */
+        unsigned char           pad[22];
+};
+
+/* Disable Channel */
+struct ncsi_cmd_dc_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;         /* Command header  */
+        unsigned char           reserved[3]; /* Reserved        */
+        unsigned char           ald;         /* Allow link down */
+        __be32                  checksum;    /* Checksum        */
+        unsigned char           pad[22];
+};
+
+/* Reset Channel */
+struct ncsi_cmd_rc_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header */
+        __be32                  reserved; /* Reserved       */
+        __be32                  checksum; /* Checksum       */
+        unsigned char           pad[22];
+};
+
+/* AEN Enable */
+struct ncsi_cmd_ae_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;         /* Command header   */
+        unsigned char           reserved[3]; /* Reserved         */
+        unsigned char           mc_id;       /* MC ID            */
+        __be32                  mode;        /* AEN working mode */
+        __be32                  checksum;    /* Checksum         */
+        unsigned char           pad[18];
+};
+
+/* Set Link */
+struct ncsi_cmd_sl_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header    */
+        __be32                  mode;     /* Link working mode */
+        __be32                  oem_mode; /* OEM link mode     */
+        __be32                  checksum; /* Checksum          */
+        unsigned char           pad[18];
+};
+
+/* Set VLAN Filter */
+struct ncsi_cmd_svf_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;       /* Command header    */
+        __be16                  reserved;  /* Reserved          */
+        __be16                  vlan;      /* VLAN ID           */
+        __be16                  reserved1; /* Reserved          */
+        unsigned char           index;     /* VLAN table index  */
+        unsigned char           enable;    /* Enable or disable */
+        __be32                  checksum;  /* Checksum          */
+        unsigned char           pad[14];
+};
+
+/* Enable VLAN */
+struct ncsi_cmd_ev_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;         /* Command header   */
+        unsigned char           reserved[3]; /* Reserved         */
+        unsigned char           mode;        /* VLAN filter mode */
+        __be32                  checksum;    /* Checksum         */
+        unsigned char           pad[22];
+};
+
+/* Set MAC Address */
+struct ncsi_cmd_sma_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header          */
+        unsigned char           mac[6];   /* MAC address             */
+        unsigned char           index;    /* MAC table index         */
+        unsigned char           at_e;     /* Addr type and operation */
+        __be32                  checksum; /* Checksum                */
+        unsigned char           pad[18];
+};
+
+/* Enable Broadcast Filter */
+struct ncsi_cmd_ebf_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header */
+        __be32                  mode;     /* Filter mode    */
+        __be32                  checksum; /* Checksum       */
+        unsigned char           pad[22];
+};
+
+/* Enable Global Multicast Filter */
+struct ncsi_cmd_egmf_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;      /* Command header */
+        __be32                  mode;     /* Global MC mode */
+        __be32                  checksum; /* Checksum       */
+        unsigned char           pad[22];
+};
+
+/* Set NCSI Flow Control */
+struct ncsi_cmd_snfc_pkt {
+        struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
+        unsigned char           reserved[3]; /* Reserved          */
+        unsigned char           mode;        /* Flow control mode */
+        __be32                  checksum;    /* Checksum          */
+        unsigned char           pad[22];
+};
+
+/* Get Link Status */
+struct ncsi_rsp_gls_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;        /* Response header   */
+        __be32                  status;     /* Link status       */
+        __be32                  other;      /* Other indications */
+        __be32                  oem_status; /* OEM link status   */
+        __be32                  checksum;
+        unsigned char           pad[10];
+};
+
+/* Get Version ID */
+struct ncsi_rsp_gvi_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;          /* Response header */
+        __be32                  ncsi_version; /* NCSI version    */
+        unsigned char           reserved[3];  /* Reserved        */
+        unsigned char           alpha2;       /* NCSI version    */
+        unsigned char           fw_name[12];  /* f/w name string */
+        __be32                  fw_version;   /* f/w version     */
+        __be16                  pci_ids[4];   /* PCI IDs         */
+        __be32                  mf_id;        /* Manufacture ID  */
+        __be32                  checksum;
+};
+
+/* Get Capabilities */
+struct ncsi_rsp_gc_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;         /* Response header   */
+        __be32                  cap;         /* Capabilities      */
+        __be32                  bc_cap;      /* Broadcast cap     */
+        __be32                  mc_cap;      /* Multicast cap     */
+        __be32                  buf_cap;     /* Buffering cap     */
+        __be32                  aen_cap;     /* AEN cap           */
+        unsigned char           vlan_cnt;    /* VLAN filter count */
+        unsigned char           mixed_cnt;   /* Mix filter count  */
+        unsigned char           mc_cnt;      /* MC filter count   */
+        unsigned char           uc_cnt;      /* UC filter count   */
+        unsigned char           reserved[2]; /* Reserved          */
+        unsigned char           vlan_mode;   /* VLAN mode         */
+        unsigned char           channel_cnt; /* Channel count     */
+        __be32                  checksum;    /* Checksum          */
+};
+
+/* Get Parameters */
+struct ncsi_rsp_gp_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;          /* Response header       *=
/
+        unsigned char           mac_cnt;      /* Number of MAC addr    *=
/
+        unsigned char           reserved[2];  /* Reserved              *=
/
+        unsigned char           mac_enable;   /* MAC addr enable flags *=
/
+        unsigned char           vlan_cnt;     /* VLAN tag count        *=
/
+        unsigned char           reserved1;    /* Reserved              *=
/
+        __be16                  vlan_enable;  /* VLAN tag enable flags *=
/
+        __be32                  link_mode;    /* Link setting          *=
/
+        __be32                  bc_mode;      /* BC filter mode        *=
/
+        __be32                  valid_modes;  /* Valid mode parameters *=
/
+        unsigned char           vlan_mode;    /* VLAN mode             *=
/
+        unsigned char           fc_mode;      /* Flow control mode     *=
/
+        unsigned char           reserved2[2]; /* Reserved              *=
/
+        __be32                  aen_mode;     /* AEN mode              *=
/
+        unsigned char           mac[6];       /* Supported MAC addr    *=
/
+        __be16                  vlan;         /* Supported VLAN tags   *=
/
+        __be32                  checksum;     /* Checksum              *=
/
+};
+
+/* Get Controller Packet Statistics */
+struct ncsi_rsp_gcps_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;            /* Response header      =
      */
+        __be32                  cnt_hi;         /* Counter cleared      =
      */
+        __be32                  cnt_lo;         /* Counter cleared      =
      */
+        __be32                  rx_bytes;       /* Rx bytes             =
      */
+        __be32                  tx_bytes;       /* Tx bytes             =
      */
+        __be32                  rx_uc_pkts;     /* Rx UC packets        =
      */
+        __be32                  rx_mc_pkts;     /* Rx MC packets        =
      */
+        __be32                  rx_bc_pkts;     /* Rx BC packets        =
      */
+        __be32                  tx_uc_pkts;     /* Tx UC packets        =
      */
+        __be32                  tx_mc_pkts;     /* Tx MC packets        =
      */
+        __be32                  tx_bc_pkts;     /* Tx BC packets        =
      */
+        __be32                  fcs_err;        /* FCS errors           =
      */
+        __be32                  align_err;      /* Alignment errors     =
      */
+        __be32                  false_carrier;  /* False carrier detecti=
on    */
+        __be32                  runt_pkts;      /* Rx runt packets      =
      */
+        __be32                  jabber_pkts;    /* Rx jabber packets    =
      */
+        __be32                  rx_pause_xon;   /* Rx pause XON frames  =
      */
+        __be32                  rx_pause_xoff;  /* Rx XOFF frames       =
      */
+        __be32                  tx_pause_xon;   /* Tx XON frames        =
      */
+        __be32                  tx_pause_xoff;  /* Tx XOFF frames       =
      */
+        __be32                  tx_s_collision; /* Single collision fram=
es    */
+        __be32                  tx_m_collision; /* Multiple collision fr=
ames  */
+        __be32                  l_collision;    /* Late collision frames=
      */
+        __be32                  e_collision;    /* Excessive collision f=
rames */
+        __be32                  rx_ctl_frames;  /* Rx control frames    =
      */
+        __be32                  rx_64_frames;   /* Rx 64-bytes frames   =
      */
+        __be32                  rx_127_frames;  /* Rx 65-127 bytes frame=
s     */
+        __be32                  rx_255_frames;  /* Rx 128-255 bytes fram=
es    */
+        __be32                  rx_511_frames;  /* Rx 256-511 bytes fram=
es    */
+        __be32                  rx_1023_frames; /* Rx 512-1023 bytes fra=
mes   */
+        __be32                  rx_1522_frames; /* Rx 1024-1522 bytes fr=
ames  */
+        __be32                  rx_9022_frames; /* Rx 1523-9022 bytes fr=
ames  */
+        __be32                  tx_64_frames;   /* Tx 64-bytes frames   =
      */
+        __be32                  tx_127_frames;  /* Tx 65-127 bytes frame=
s     */
+        __be32                  tx_255_frames;  /* Tx 128-255 bytes fram=
es    */
+        __be32                  tx_511_frames;  /* Tx 256-511 bytes fram=
es    */
+        __be32                  tx_1023_frames; /* Tx 512-1023 bytes fra=
mes   */
+        __be32                  tx_1522_frames; /* Tx 1024-1522 bytes fr=
ames  */
+        __be32                  tx_9022_frames; /* Tx 1523-9022 bytes fr=
ames  */
+        __be32                  rx_valid_bytes; /* Rx valid bytes       =
      */
+        __be32                  rx_runt_pkts;   /* Rx error runt packets=
      */
+        __be32                  rx_jabber_pkts; /* Rx error jabber packe=
ts    */
+        __be32                  checksum;       /* Checksum             =
      */
+};
+
+/* Get NCSI Statistics */
+struct ncsi_rsp_gns_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;           /* Response header       =
  */
+        __be32                  rx_cmds;       /* Rx NCSI commands      =
  */
+        __be32                  dropped_cmds;  /* Dropped commands      =
  */
+        __be32                  cmd_type_errs; /* Command type errors   =
  */
+        __be32                  cmd_csum_errs; /* Command checksum error=
s */
+        __be32                  rx_pkts;       /* Rx NCSI packets       =
  */
+        __be32                  tx_pkts;       /* Tx NCSI packets       =
  */
+        __be32                  tx_aen_pkts;   /* Tx AEN packets        =
  */
+        __be32                  checksum;      /* Checksum              =
  */
+};
+
+/* Get NCSI Pass-through Statistics */
+struct ncsi_rsp_gnpts_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;            /* Response header     *=
/
+        __be32                  tx_pkts;        /* Tx packets          *=
/
+        __be32                  tx_dropped;     /* Tx dropped packets  *=
/
+        __be32                  tx_channel_err; /* Tx channel errors   *=
/
+        __be32                  tx_us_err;      /* Tx undersize errors *=
/
+        __be32                  rx_pkts;        /* Rx packets          *=
/
+        __be32                  rx_dropped;     /* Rx dropped packets  *=
/
+        __be32                  rx_channel_err; /* Rx channel errors   *=
/
+        __be32                  rx_us_err;      /* Rx undersize errors *=
/
+        __be32                  rx_os_err;      /* Rx oversize errors  *=
/
+        __be32                  checksum;       /* Checksum            *=
/
+};
+
+/* Get package status */
+struct ncsi_rsp_gps_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;      /* Response header            =
 */
+        __be32                  status;   /* Hardware arbitration status=
 */
+        __be32                  checksum;
+};
+
+/* Get package UUID */
+struct ncsi_rsp_gpuuid_pkt {
+        struct ncsi_rsp_pkt_hdr rsp;      /* Response header */
+        unsigned char           uuid[16]; /* UUID            */
+        __be32                  checksum;
+};
+
+/* AEN: Link State Change */
+struct ncsi_aen_lsc_pkt {
+        struct ncsi_aen_pkt_hdr aen;        /* AEN header      */
+        __be32                  status;     /* Link status     */
+        __be32                  oem_status; /* OEM link status */
+        __be32                  checksum;   /* Checksum        */
+        unsigned char           pad[14];
+};
+
+/* AEN: Configuration Required */
+struct ncsi_aen_cr_pkt {
+        struct ncsi_aen_pkt_hdr aen;      /* AEN header */
+        __be32                  checksum; /* Checksum   */
+        unsigned char           pad[22];
+};
+
+/* AEN: Host Network Controller Driver Status Change */
+struct ncsi_aen_hncdsc_pkt {
+        struct ncsi_aen_pkt_hdr aen;      /* AEN header */
+        __be32                  status;   /* Status     */
+        __be32                  checksum; /* Checksum   */
+        unsigned char           pad[18];
+};
+
+/* NCSI packet revision */
+#define NCSI_PKT_REVISION       0x01
+
+/* NCSI packet commands */
+#define NCSI_PKT_CMD_CIS        0x00 /* Clear Initial State             =
 */
+#define NCSI_PKT_CMD_SP         0x01 /* Select Package                  =
 */
+#define NCSI_PKT_CMD_DP         0x02 /* Deselect Package                =
 */
+#define NCSI_PKT_CMD_EC         0x03 /* Enable Channel                  =
 */
+#define NCSI_PKT_CMD_DC         0x04 /* Disable Channel                 =
 */
+#define NCSI_PKT_CMD_RC         0x05 /* Reset Channel                   =
 */
+#define NCSI_PKT_CMD_ECNT       0x06 /* Enable Channel Network Tx       =
 */
+#define NCSI_PKT_CMD_DCNT       0x07 /* Disable Channel Network Tx      =
 */
+#define NCSI_PKT_CMD_AE         0x08 /* AEN Enable                      =
 */
+#define NCSI_PKT_CMD_SL         0x09 /* Set Link                        =
 */
+#define NCSI_PKT_CMD_GLS        0x0a /* Get Link                        =
 */
+#define NCSI_PKT_CMD_SVF        0x0b /* Set VLAN Filter                 =
 */
+#define NCSI_PKT_CMD_EV         0x0c /* Enable VLAN                     =
 */
+#define NCSI_PKT_CMD_DV         0x0d /* Disable VLAN                    =
 */
+#define NCSI_PKT_CMD_SMA        0x0e /* Set MAC address                 =
 */
+#define NCSI_PKT_CMD_EBF        0x10 /* Enable Broadcast Filter         =
 */
+#define NCSI_PKT_CMD_DBF        0x11 /* Disable Broadcast Filter        =
 */
+#define NCSI_PKT_CMD_EGMF       0x12 /* Enable Global Multicast Filter  =
 */
+#define NCSI_PKT_CMD_DGMF       0x13 /* Disable Global Multicast Filter =
 */
+#define NCSI_PKT_CMD_SNFC       0x14 /* Set NCSI Flow Control           =
 */
+#define NCSI_PKT_CMD_GVI        0x15 /* Get Version ID                  =
 */
+#define NCSI_PKT_CMD_GC         0x16 /* Get Capabilities                =
 */
+#define NCSI_PKT_CMD_GP         0x17 /* Get Parameters                  =
 */
+#define NCSI_PKT_CMD_GCPS       0x18 /* Get Controller Packet Statistics=
 */
+#define NCSI_PKT_CMD_GNS        0x19 /* Get NCSI Statistics             =
 */
+#define NCSI_PKT_CMD_GNPTS      0x1a /* Get NCSI Pass-throu Statistics  =
 */
+#define NCSI_PKT_CMD_GPS        0x1b /* Get package status              =
 */
+#define NCSI_PKT_CMD_OEM        0x50 /* OEM                             =
 */
+#define NCSI_PKT_CMD_PLDM       0x51 /* PLDM request over NCSI over RBT =
 */
+#define NCSI_PKT_CMD_GPUUID     0x52 /* Get package UUID                =
 */
+
+/* NCSI packet responses */
+#define NCSI_PKT_RSP_CIS        (NCSI_PKT_CMD_CIS    + 0x80)
+#define NCSI_PKT_RSP_SP         (NCSI_PKT_CMD_SP     + 0x80)
+#define NCSI_PKT_RSP_DP         (NCSI_PKT_CMD_DP     + 0x80)
+#define NCSI_PKT_RSP_EC         (NCSI_PKT_CMD_EC     + 0x80)
+#define NCSI_PKT_RSP_DC         (NCSI_PKT_CMD_DC     + 0x80)
+#define NCSI_PKT_RSP_RC         (NCSI_PKT_CMD_RC     + 0x80)
+#define NCSI_PKT_RSP_ECNT       (NCSI_PKT_CMD_ECNT   + 0x80)
+#define NCSI_PKT_RSP_DCNT       (NCSI_PKT_CMD_DCNT   + 0x80)
+#define NCSI_PKT_RSP_AE         (NCSI_PKT_CMD_AE     + 0x80)
+#define NCSI_PKT_RSP_SL         (NCSI_PKT_CMD_SL     + 0x80)
+#define NCSI_PKT_RSP_GLS        (NCSI_PKT_CMD_GLS    + 0x80)
+#define NCSI_PKT_RSP_SVF        (NCSI_PKT_CMD_SVF    + 0x80)
+#define NCSI_PKT_RSP_EV         (NCSI_PKT_CMD_EV     + 0x80)
+#define NCSI_PKT_RSP_DV         (NCSI_PKT_CMD_DV     + 0x80)
+#define NCSI_PKT_RSP_SMA        (NCSI_PKT_CMD_SMA    + 0x80)
+#define NCSI_PKT_RSP_EBF        (NCSI_PKT_CMD_EBF    + 0x80)
+#define NCSI_PKT_RSP_DBF        (NCSI_PKT_CMD_DBF    + 0x80)
+#define NCSI_PKT_RSP_EGMF       (NCSI_PKT_CMD_EGMF   + 0x80)
+#define NCSI_PKT_RSP_DGMF       (NCSI_PKT_CMD_DGMF   + 0x80)
+#define NCSI_PKT_RSP_SNFC       (NCSI_PKT_CMD_SNFC   + 0x80)
+#define NCSI_PKT_RSP_GVI        (NCSI_PKT_CMD_GVI    + 0x80)
+#define NCSI_PKT_RSP_GC         (NCSI_PKT_CMD_GC     + 0x80)
+#define NCSI_PKT_RSP_GP         (NCSI_PKT_CMD_GP     + 0x80)
+#define NCSI_PKT_RSP_GCPS       (NCSI_PKT_CMD_GCPS   + 0x80)
+#define NCSI_PKT_RSP_GNS        (NCSI_PKT_CMD_GNS    + 0x80)
+#define NCSI_PKT_RSP_GNPTS      (NCSI_PKT_CMD_GNPTS  + 0x80)
+#define NCSI_PKT_RSP_GPS        (NCSI_PKT_CMD_GPS    + 0x80)
+#define NCSI_PKT_RSP_OEM        (NCSI_PKT_CMD_OEM    + 0x80)
+#define NCSI_PKT_RSP_PLDM       (NCSI_PKT_CMD_PLDM   + 0x80)
+#define NCSI_PKT_RSP_GPUUID     (NCSI_PKT_CMD_GPUUID + 0x80)
+
+/* NCSI response code/reason */
+#define NCSI_PKT_RSP_C_COMPLETED        0x0000 /* Command Completed     =
   */
+#define NCSI_PKT_RSP_C_FAILED           0x0001 /* Command Failed        =
   */
+#define NCSI_PKT_RSP_C_UNAVAILABLE      0x0002 /* Command Unavailable   =
   */
+#define NCSI_PKT_RSP_C_UNSUPPORTED      0x0003 /* Command Unsupported   =
   */
+#define NCSI_PKT_RSP_R_NO_ERROR         0x0000 /* No Error              =
   */
+#define NCSI_PKT_RSP_R_INTERFACE        0x0001 /* Interface not ready   =
   */
+#define NCSI_PKT_RSP_R_PARAM            0x0002 /* Invalid Parameter     =
   */
+#define NCSI_PKT_RSP_R_CHANNEL          0x0003 /* Channel not Ready     =
   */
+#define NCSI_PKT_RSP_R_PACKAGE          0x0004 /* Package not Ready     =
   */
+#define NCSI_PKT_RSP_R_LENGTH           0x0005 /* Invalid payload length=
   */
+#define NCSI_PKT_RSP_R_UNKNOWN          0x7fff /* Command type unsupport=
ed */
+
+/* NCSI AEN packet type */
+#define NCSI_PKT_AEN            0xFF /* AEN Packet               */
+#define NCSI_PKT_AEN_LSC        0x00 /* Link status change       */
+#define NCSI_PKT_AEN_CR         0x01 /* Configuration required   */
+#define NCSI_PKT_AEN_HNCDSC     0x02 /* HNC driver status change */
+
+#endif /* NCSI_PKT_H */
diff --git a/slirp/ncsi.c b/slirp/ncsi.c
new file mode 100644
index 000000000000..77302ec5e5a5
--- /dev/null
+++ b/slirp/ncsi.c
@@ -0,0 +1,78 @@
+/*
+ * NC-SI (Network Controller Sideband Interface) "echo" model
+ *
+ * Copyright (C) 2016 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "slirp.h"
+
+#include "ncsi-pkt.h"
+
+/*
+ * ncsi header + checksum + max payload (NCSI_PKT_CMD_GVI)
+ */
+#define NCSI_LEN (sizeof(struct ncsi_pkt_hdr) + 4 + 36)
+
+void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
+{
+    struct ncsi_pkt_hdr *nh =3D (struct ncsi_pkt_hdr *)(pkt + ETH_HLEN);
+    uint8_t ncsi_reply[ETH_HLEN + NCSI_LEN];
+    struct ethhdr *reh =3D (struct ethhdr *)ncsi_reply;
+    struct ncsi_rsp_pkt_hdr *rnh =3D (struct ncsi_rsp_pkt_hdr *)
+        (ncsi_reply + ETH_HLEN);
+
+    memset(ncsi_reply, 0, sizeof(ncsi_reply));
+
+    memset(reh->h_dest, 0xff, ETH_ALEN);
+    memset(reh->h_source, 0xff, ETH_ALEN);
+    reh->h_proto =3D htons(ETH_P_NCSI);
+
+    rnh->common.mc_id        =3D nh->mc_id;
+    rnh->common.revision     =3D NCSI_PKT_REVISION;
+    rnh->common.reserved     =3D 0;
+    rnh->common.id           =3D nh->id;
+    rnh->common.type         =3D nh->type + 0x80;
+    rnh->common.channel      =3D nh->channel;
+    rnh->common.length       =3D htons(4);
+    rnh->common.reserved1[0] =3D 0;
+    rnh->common.reserved1[1] =3D 0;
+    rnh->code         =3D htons(NCSI_PKT_RSP_C_COMPLETED);
+    rnh->reason       =3D htons(NCSI_PKT_RSP_R_NO_ERROR);
+
+    switch (nh->type) {
+    case NCSI_PKT_CMD_SMA:
+        rnh->common.length =3D htons(4);
+        break;
+    case NCSI_PKT_CMD_GVI:
+        rnh->common.length =3D htons(36);
+        break;
+    case NCSI_PKT_CMD_GC: {
+        struct ncsi_rsp_gc_pkt *rsp =3D (struct ncsi_rsp_gc_pkt *) rnh;
+
+        rnh->common.length =3D htons(32);
+        rsp->cap =3D htonl(~0);
+        rsp->bc_cap =3D htonl(~0);
+        rsp->mc_cap =3D htonl(~0);
+        rsp->buf_cap =3D htonl(~0);
+        rsp->aen_cap =3D htonl(~0);
+        rsp->vlan_mode =3D 0xff;
+        rsp->uc_cnt =3D 2;
+        break;
+    }
+
+    case NCSI_PKT_CMD_GLS: {
+        struct ncsi_rsp_gls_pkt *rsp =3D (struct ncsi_rsp_gls_pkt *) rnh=
;
+
+        rnh->common.length =3D htons(16);
+        rsp->status =3D htonl(0x1);
+        break;
+    }
+    default:
+        break;
+    }
+
+    slirp_output(slirp->opaque, ncsi_reply, sizeof(ncsi_reply));
+}
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 5a94b06f5eb4..9a50918346b1 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -870,6 +870,10 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, i=
nt pkt_len)
         }
         break;
=20
+    case ETH_P_NCSI:
+        ncsi_input(slirp, pkt, pkt_len);
+        break;
+
     default:
         break;
     }
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 3877f667f027..5af4f482b55f 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -231,6 +231,9 @@ extern Slirp *slirp_instance;
=20
 void if_start(Slirp *);
=20
+/* ncsi.c */
+void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len);
+
 #ifndef _WIN32
 #include <netdb.h>
 #endif
--=20
2.7.4
