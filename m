Received: from eggs.gnu.org ([2001:4830:134:3::10]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx4-0004K5-3L
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx3-00038f-BB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwxx3-00038H-5S
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 19:03:26 -0300
Message-Id: <20170926220326.12996-5-ehabkost@redhat.com>
In-Reply-To: <20170926220326.12996-1-ehabkost@redhat.com>
References: <20170926220326.12996-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] device-crash-test: Use query-device-info
 for user-creatable check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <dgibson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>

Now that we have query-device-info, we don't need to parse "info
qdm" output to find out if a device is user-creatable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 043b24a4aa..ddc8f72eca 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -318,19 +318,6 @@ def qomListTypeNames(vm, **kwargs):
     return [t['name'] for t in types]
 
 
-def infoQDM(vm):
-    """Parse 'info qdm' output"""
-    args = {'command-line': 'info qdm'}
-    devhelp = vm.command('human-monitor-command', **args)
-    for l in devhelp.split('\n'):
-        l = l.strip()
-        if l == '' or l.endswith(':'):
-            continue
-        d = {'name': re.search(r'name "([^"]+)"', l).group(1),
-             'no-user': (re.search(', no-user', l) is not None)}
-        yield d
-
-
 class QemuBinaryInfo(object):
     def __init__(self, binary, devtype):
         if devtype is None:
@@ -346,11 +333,9 @@ class QemuBinaryInfo(object):
         vm.launch()
         try:
             self.alldevs = set(qomListTypeNames(vm, implements=devtype, abstract=False))
-            # there's no way to query DeviceClass::user_creatable using QMP,
-            # so use 'info qdm':
-            self.no_user_devs = set([d['name'] for d in infoQDM(vm, ) if d['no-user']])
+            self.dev_info = dict((t, vm.command('query-device-type', typename=t)) for t in self.alldevs)
+            self.user_devs = set(d for d in self.alldevs if self.dev_info[d]['user-creatable'])
             self.machines = list(m['name'] for m in vm.command('query-machines'))
-            self.user_devs = self.alldevs.difference(self.no_user_devs)
             self.kvm_available = vm.command('query-kvm')['enabled']
         finally:
             vm.shutdown()
-- 
2.13.5
