Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE7C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC21421907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="q2sXyTsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC21421907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjKE-0006Do-8e
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEW-0000GK-KZ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEU-0002Ub-RH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:36 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
 ([40.107.71.132]:6167 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEU-0002SZ-JN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHTy4WhzBrsbqx4tFlnabG+bj/4kvjLCodgwpKZneBGE3sI96ySWdZpJNXx7fFpdf6PQN/L6D2PdHWuo4IfAWBQ3We/FjpTCZqp3i1/fl92ojaUip4ERsmoJHcKTcxYmJ30hbp3EjnnJRYEi+F8ERbtmh5PnXoQAK2RVTlkOWvMMuhpMRGK91uBCpyBdIc3BgTaXQBnmZO513ALqmrI3416L95zWWZIkUMI3DAaLgZKskLrYQozLfiG+j5XomG3p94MrE7+PVfcNI9Lk2R6e2UCy0SQ2n5/Hf4GaTI2+68eFTeKnM/V/ZeBlkDJAxG7F5b8V8XJRJD5A9/gRKvJTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT+9bNaJb5U/5qjKkIuVId2sNqiXfCsoNNkJNF9cROM=;
 b=mfWQWvggHZit4fYqkNH0sZMpbYY+ZVv3/r4xrRAcav1GG/BRmzjld4+83bDcQWg4G3jb5k1kWlJi6tlfO8fE37/Eq9AYxUg/ZVqWRRgfq8sFggRmewTzpR1bdVP7KezIdC4m0M4HHG1tx9paDyIpIngOPWOwpmViWmr9V+poQsSLS6jklUd9AOPsAfJP4htBKYbC2ea5kGb4NYMBacOZPAHgMd3M5QSpTHka0pXvdvv7Lzw7UeWtLsoHvX+0Wm9OT3icD+lkMQNw84qiLgrcs2XSKWS4KlxMT5HjT0xStcjuvpM3PUkxuJem9C4j/cHTx155XThH5p3tg/rXb2UMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT+9bNaJb5U/5qjKkIuVId2sNqiXfCsoNNkJNF9cROM=;
 b=q2sXyTsB93zVpd9V/sAqllEQA72amUg2pekG4Z7Udrr5sN3VyBgZDv56sIkiJZvQxfrxyFxk7vLGKrqRxbIybpqGEQY2dEZHngN8w8kdpO+yu3NnJaWfhCpdNBvfc97gt3Ox7JFThHIt4JpeWK9wmcmZMYhG3n3LSe+/a3fS/iA=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:32 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:32 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 05/22] libqtest: Add a layer of abstraciton to
 send/recv
Thread-Index: AQHVbneHp+c4RlezBUGXNefN9Lzx6g==
Date: Wed, 18 Sep 2019 23:19:32 +0000
Message-ID: <20190918231846.22538-6-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61bedc98-488c-41f4-4134-08d73c8ea991
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB301686B59EAB4110DD5E4D15BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ss5Ty4LCveZQDBkvOrxDU359eszrbLiO1kk0S4bzbGEJiv9z6TiDbeW66mEFD0UrGU37mydeV0vRpzWTOzsKlB4VoG8R5wvVGHdSPwOjQTfsDz7KuP80X+nEMgfbR1ARemgzllA9Rwd2VcAYGiQzK7qrLV3AxWEtFIgmyn2JS2AVczAdi/WJg/naZH01io3y/FvEeQGCYBB/tX2nvDN5fAeX0pHo5N9GLmM8NQNbsKFgN/rx85FG7VjKvPjSv3eYv/KpSbk5HPqsgcTFr8px58I9EdIq1tpDIxsmIFgqgXFX82Zg6mReukQrJP86jG55aacEA6UVlgQc3sOu3OGL545f5F0oDplEiFspMW2ZAMJqN5CjEMur+9iPFuqO/Mn+HqaRHZuY3kKJxc4Faj/NCQbAP9MheJgoFE9xCcUHT18=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bedc98-488c-41f4-4134-08d73c8ea991
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:32.7694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TP2qhLR81rhovJeZgLWpcJ8nsQqU958T6ABvNrKjZf3erfWEPbxtYfBwZxoZ3LR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.132
Subject: [Qemu-devel] [PATCH v3 05/22] libqtest: Add a layer of abstraciton
 to send/recv
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it simple to swap the transport functions for qtest commands
to and from the qtest client. For example, now it is possible to
directly pass qtest commands to a server handler that exists within the
same process, without the standard way of writing to a file descriptor.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 64 +++++++++++++++++++++++++++++++++++++++---------
 tests/libqtest.h |  1 -
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a7556462d..19feea9e17 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -35,6 +35,15 @@
 #define SOCKET_TIMEOUT 50
 #define SOCKET_MAX_FDS 16
=20
+
+typedef struct QTestClientTransportOps {
+    void     (*send)(void* , const char*, size_t);
+    void     *send_opaque;
+
+    GString* (*recv_line)(void *);
+    void     *recv_line_opaque;
+} QTestTransportOps;
+
 struct QTestState
 {
     int fd;
@@ -45,13 +54,28 @@ struct QTestState
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
+    QTestTransportOps ops;
 };
=20
 static GHookList abrt_hooks;
 static struct sigaction sigact_old;
+static GString *recv_str;
=20
 static int qtest_query_target_endianness(QTestState *s);
=20
+static void qtest_client_socket_send(void *opaque,
+        const char *buf, size_t size);
+static void socket_send(int fd, const char *buf, size_t size);
+
+static GString *qtest_client_socket_recv_line(void *);
+static GString *qtest_client_inproc_recv_line(void *);
+
+static void qtest_client_set_tx_handler(QTestState *s,
+        void (*send)(void *, const char *, size_t), void *opaque);
+static void qtest_client_set_rx_handler(QTestState *s,
+        GString * (*recv)(void *), void *opaque);
+
+
 static int init_socket(const char *socket_path)
 {
     struct sockaddr_un addr;
@@ -234,6 +258,9 @@ QTestState *qtest_init_without_qmp_handshake(const char=
 *extra_args)
     sock =3D init_socket(socket_path);
     qmpsock =3D init_socket(qmp_socket_path);
=20
+    qtest_client_set_rx_handler(s, qtest_client_socket_recv_line, s);
+    qtest_client_set_tx_handler(s, qtest_client_socket_send, &(s->fd));
+
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
=20
     command =3D g_strdup_printf("exec %s "
@@ -360,8 +387,9 @@ void qtest_quit(QTestState *s)
     g_free(s);
 }
=20
-static void socket_send(int fd, const char *buf, size_t size)
+static void qtest_client_socket_send(void *opaque, const char *buf, size_t=
 size)
 {
+    int fd =3D *((int *)opaque);
     size_t offset;
=20
     offset =3D 0;
@@ -379,22 +407,22 @@ static void socket_send(int fd, const char *buf, size=
_t size)
     }
 }
=20
-static void socket_sendf(int fd, const char *fmt, va_list ap)
+static void socket_send(int fd, const char *buf, size_t size)
 {
-    gchar *str =3D g_strdup_vprintf(fmt, ap);
-    size_t size =3D strlen(str);
-
-    socket_send(fd, str, size);
-    g_free(str);
+    qtest_client_socket_send(&fd, buf, size);
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt,=
 ...)
 {
     va_list ap;
-
     va_start(ap, fmt);
-    socket_sendf(s->fd, fmt, ap);
+    gchar *str =3D g_strdup_vprintf(fmt, ap);
     va_end(ap);
+
+    size_t size =3D strlen(str);
+
+    s->ops.send(s, str, size);
+    g_free(str);
 }
=20
 /* Sends a message and file descriptors to the socket.
@@ -431,8 +459,9 @@ static void socket_send_fds(int socket_fd, int *fds, si=
ze_t fds_num,
     g_assert_cmpint(ret, >, 0);
 }
=20
-static GString *qtest_recv_line(QTestState *s)
+static GString *qtest_client_socket_recv_line(void* opaque)
 {
+    QTestState *s =3D opaque;
     GString *line;
     size_t offset;
     char *eol;
@@ -468,7 +497,7 @@ static gchar **qtest_rsp(QTestState *s, int expected_ar=
gs)
     int i;
=20
 redo:
-    line =3D qtest_recv_line(s);
+    line =3D s->ops.recv_line(s->ops.recv_line_opaque);
     words =3D g_strsplit(line->str, " ", 0);
     g_string_free(line, TRUE);
=20
@@ -1327,3 +1356,16 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class)
=20
     qobject_unref(rsp);
 }
+
+static void qtest_client_set_tx_handler(QTestState *s,
+                    void (*send)(void*, const char*, size_t), void *opaque=
)
+{
+    s->ops.send =3D send;
+    s->ops.send_opaque =3D opaque;
+}
+static void qtest_client_set_rx_handler(QTestState *s,
+                    GString* (*recv)(void *), void *opaque)
+{
+    s->ops.recv_line =3D recv;
+    s->ops.recv_line_opaque =3D opaque;
+}
diff --git a/tests/libqtest.h b/tests/libqtest.h
index a177e502d9..40fa235a52 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -716,5 +716,4 @@ bool qtest_probe_child(QTestState *s);
  * Set expected exit status of the child.
  */
 void qtest_set_expected_status(QTestState *s, int status);
-
 #endif
--=20
2.23.0


