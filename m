Received: from eggs.gnu.org ([2001:4830:134:3::10]:44460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ebGg6-0006TU-17
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shaun.reitan@ndchost.com>) id 1ebGg2-0001bY-Pb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:08:41 -0500
Received: from jade.ndchost.com ([204.10.36.36]:41620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shaun.reitan@ndchost.com>)
	id 1ebGg2-0001aE-F0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 21:08:38 -0500
From: "Shaun Reitan" <shaun.reitan@ndchost.com>
Date: Tue, 16 Jan 2018 02:08:37 +0000
Message-Id: <em00d1f357-435b-458c-8d9f-6e89c94a4c61@ndc-wkst-2>
Reply-To: "Shaun Reitan" <shaun.reitan@ndchost.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/1] Add ifname support to -netdev tap and
 bridge when using helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org

Hi, I've modified the qemu source to add support for specifying a ifname=20
when using -netdev tap or -netdev bridge with a helper. Currently this=20
is not supported and all interface names are named tap0, tap1, ...

Hopfully i'm submitting this correctly, if not I appologize. Also, my C=20
is a bit rusty... well it was never great to begin with :)

--
Shaun Reitan
NDCHost.com


>From 9af8c88781d63637822c6edea1f83e98199a570b Mon Sep 17 00:00:00 2001
From: Shaun Reitan <shaun.reitan@ndchost.com>
Date: Mon, 15 Jan 2018 17:40:38 -0800
Subject: [PATCH 1/4] Add support for setting a TAP interface name

Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
---
  qemu-bridge-helper.c | 11 +++++++++--
  1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 5396fbf..7b01cd5 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -57,7 +57,7 @@ typedef QSIMPLEQ_HEAD(ACLList, ACLRule) ACLList;
  static void usage(void)
  {
      fprintf(stderr,
- "Usage: qemu-bridge-helper [--use-vnet] --br=3Dbridge --fd=3Dunixfd\n");
+ "Usage: qemu-bridge-helper [--use-vnet] --br=3Dbridge --fd=3Dunixfd=20
[--ifname=3Dname]\n");
  }

  static int parse_acl_file(const char *filename, ACLList *acl_list)
@@ -223,6 +223,7 @@ int main(int argc, char **argv)
      int use_vnet =3D 0;
      int mtu;
      const char *bridge =3D NULL;
+ const char *ifname =3D NULL;
      char iface[IFNAMSIZ];
      int index;
      ACLRule *acl_rule;
@@ -249,6 +250,8 @@ int main(int argc, char **argv)
              bridge =3D &argv[index][5];
          } else if (strncmp(argv[index], "--fd=3D", 5) =3D=3D 0) {
              unixfd =3D atoi(&argv[index][5]);
+ } else if (strncmp(argv[index], "--ifname=3D", 9) =3D=3D 0) {
+ ifname =3D &argv[index][9];
          } else {
              usage();
              return EXIT_FAILURE;
@@ -320,7 +323,11 @@ int main(int argc, char **argv)

      /* request a tap device, disable PI, and add vnet header support if
       * requested and it's available. */
- prep_ifreq(&ifr, "tap%d");
+ if (ifname =3D=3D NULL) {
+ prep_ifreq(&ifr, "tap%d");
+ } else {
+ prep_ifreq(&ifr, ifname);
+ }
      ifr.ifr_flags =3D IFF_TAP|IFF_NO_PI;
      if (use_vnet && has_vnet_hdr(fd)) {
          ifr.ifr_flags |=3D IFF_VNET_HDR;
--
2.9.5


>From 35a24821d437d1955c00dc64f7cd82d24e31ecda Mon Sep 17 00:00:00 2001
From: Shaun Reitan <shaun.reitan@ndchost.com>
Date: Mon, 15 Jan 2018 17:42:32 -0800
Subject: [PATCH 2/4] Add ifname to NetdevBridgeOptions

Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
---
  qapi/net.json | 1 +
  1 file changed, 1 insertion(+)

diff --git a/qapi/net.json b/qapi/net.json
index 4beff5d..5b5b281 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -402,6 +402,7 @@
  { 'struct': 'NetdevBridgeOptions',
    'data': {
      '*br': 'str',
+ '*ifname': 'str',
      '*helper': 'str' } }

  ##
--
2.9.5


>From 92bbc897a04628358e6d698d70c5a257a912b67c Mon Sep 17 00:00:00 2001
From: Shaun Reitan <shaun.reitan@ndchost.com>
Date: Mon, 15 Jan 2018 17:43:24 -0800
Subject: [PATCH 3/4] Add ifname support to -netdev bridge options

Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
---
  qemu-options.hx | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 678181c..81cbc3c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1961,7 +1961,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
      " use 'queues=3Dn' to specify the number of queues to be created for=
=20
multiqueue TAP\n"
      " use 'poll-us=3Dn' to speciy the maximum number of microseconds that=
=20
could be\n"
      " spent on busy polling for vhost net\n"
- "-netdev bridge,id=3Dstr[,br=3Dbridge][,helper=3Dhelper]\n"
+ "-netdev bridge,id=3Dstr[,br=3Dbridge][,helper=3Dhelper][,ifname=3Dname]\=
n"
      " configure a host TAP network backend with ID 'str' that is\n"
      " connected to a bridge (default=3D" DEFAULT_BRIDGE_INTERFACE ")\n"
      " using the program 'helper (default=3D" DEFAULT_BRIDGE_HELPER ")\n"
--
2.9.5


>From 797ca0174430ffd0dc8c5a36ce86380816ff2eee Mon Sep 17 00:00:00 2001
From: Shaun Reitan <shaun.reitan@ndchost.com>
Date: Mon, 15 Jan 2018 17:43:42 -0800
Subject: [PATCH 4/4] Add ability to set ifname when using -netdev bridge=20
and
  -netdev tap when using a helper

Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
---
  net/tap.c | 30 +++++++++++++++++++++---------
  1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 979e622..1180094 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -472,7 +472,7 @@ static int recv_fd(int c)
  }

  static int net_bridge_run_helper(const char *helper, const char=20
*bridge,
- Error **errp)
+ const char *ifname, Error **errp)
  {
      sigset_t oldmask, mask;
      int pid, status;
@@ -499,7 +499,8 @@ static int net_bridge_run_helper(const char *helper,=20
const char *bridge,
          int open_max =3D sysconf(_SC_OPEN_MAX), i;
          char fd_buf[6+10];
          char br_buf[6+IFNAMSIZ] =3D {0};
- char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15];
+ char ifname_buf[10+IFNAMSIZ];
+ char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) +=20
sizeof(ifname_buf) + 15];

          for (i =3D 3; i < open_max; i++) {
              if (i !=3D sv[1]) {
@@ -516,8 +517,12 @@ static int net_bridge_run_helper(const char=20
*helper, const char *bridge,
                  snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D",=20
bridge);
              }

- snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
- helper, "--use-vnet", fd_buf, br_buf);
+ if (strstr(helper, "--ifname=3D") =3D=3D NULL && ifname !=3D NULL) {
+ snprintf(ifname_buf, sizeof(ifname_buf), "%s%s", "--ifname=3D", ifname);
+ }
+
+ snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s %s",
+ helper, "--use-vnet", fd_buf, br_buf, ifname_buf);

              parg =3D args;
              *parg++ =3D (char *)"sh";
@@ -536,6 +541,12 @@ static int net_bridge_run_helper(const char=20
*helper, const char *bridge,
              *parg++ =3D (char *)"--use-vnet";
              *parg++ =3D fd_buf;
              *parg++ =3D br_buf;
+
+ if (ifname !=3D NULL) {
+ snprintf(ifname_buf, sizeof(ifname_buf), "%s%s", "--ifname=3D", ifname);
+ *parg++ =3D ifname_buf;
+ }
+
              *parg++ =3D NULL;

              execv(helper, args);
@@ -586,7 +597,7 @@ int net_init_bridge(const Netdev *netdev, const char=20
*name,
      helper =3D bridge->has_helper ? bridge->helper :=20
DEFAULT_BRIDGE_HELPER;
      br =3D bridge->has_br ? bridge->br : DEFAULT_BRIDGE_INTERFACE;

- fd =3D net_bridge_run_helper(helper, br, errp);
+ fd =3D net_bridge_run_helper(helper, br, bridge->ifname, errp);
      if (fd =3D=3D -1) {
          return -1;
      }
@@ -854,16 +865,17 @@ free_fail:
          g_free(vhost_fds);
          return -1;
      } else if (tap->has_helper) {
- if (tap->has_ifname || tap->has_script || tap->has_downscript ||
- tap->has_vnet_hdr || tap->has_queues || tap->has_vhostfds) {
- error_setg(errp, "ifname=3D, script=3D, downscript=3D, vnet_hdr=3D, "
- "queues=3D, and vhostfds=3D are invalid with helper=3D");
+ if (tap->has_script || tap->has_downscript || tap->has_vnet_hdr ||
+ tap->has_queues || tap->has_vhostfds) {
+ error_setg(errp, "script=3D, downscript=3D, vnet_hdr=3D, queues=3D, and "
+ "vhostfds=3D are invalid with helper=3D");
              return -1;
          }

          fd =3D net_bridge_run_helper(tap->helper,
                                     tap->has_br ?
                                     tap->br : DEFAULT_BRIDGE_INTERFACE,
+ tap->ifname,
                                     errp);
          if (fd =3D=3D -1) {
              return -1;
--
2.9.5
