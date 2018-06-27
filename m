Received: from eggs.gnu.org ([2001:4830:134:3::10]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzz3-0006yx-Ma
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzz2-0002G2-BR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzz2-0002Fg-2s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:20 -0300
Message-Id: <20180627021423.18404-4-ehabkost@redhat.com>
In-Reply-To: <20180627021423.18404-1-ehabkost@redhat.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] docker: Add type annotations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add type annotations that indicate how the code works today, to
make the conversion to Python 3 easier and safer.

With these type annotations, "mypy -2" is not reporting any
issues, but "mypy" in Python 3 mode reports a few problems:

tests/docker/docker.py:233: error: Argument 1 to "_text_checksum" has incompatible type "str"; expected "bytes"
tests/docker/docker.py:358: error: "_Environ[str]" has no attribute "iteritems"
tests/docker/docker.py:360: error: Argument 3 to "build_image" of "Docker" has incompatible type "bytes"; expected "str"

These problems will be addressed by the following commits.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 44 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e3bfa1cc9e..db6b463b92 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -29,6 +29,12 @@ from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime,timedelta
 
+try:
+    from typing import List, Union, Tuple
+except ImportError:
+    # needed only to make type annotations work
+    pass
+
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
 
@@ -37,13 +43,16 @@ DEVNULL = open(os.devnull, 'wb')
 
 
 def _text_checksum(text):
+    # type: (bytes) -> str
     """Calculate a digest string unique to the text content"""
     return hashlib.sha1(text).hexdigest()
 
 def _file_checksum(filename):
+    # type: (str) -> str
     return _text_checksum(open(filename, 'rb').read())
 
 def _guess_docker_command():
+    # type: () -> List[str]
     """ Guess a working docker command or raise exception if not found"""
     commands = [["docker"], ["sudo", "-n", "docker"]]
     for cmd in commands:
@@ -60,6 +69,7 @@ def _guess_docker_command():
                     commands_txt)
 
 def _copy_with_mkdir(src, root_dir, sub_path='.'):
+    # type: (str, str, str) -> None
     """Copy src into root_dir, creating sub_path as needed."""
     dest_dir = os.path.normpath("%s/%s" % (root_dir, sub_path))
     try:
@@ -73,6 +83,7 @@ def _copy_with_mkdir(src, root_dir, sub_path='.'):
 
 
 def _get_so_libs(executable):
+    # type: (str) -> List[str]
     """Return a list of libraries associated with an executable.
 
     The paths may be symbolic links which would need to be resolved to
@@ -94,6 +105,7 @@ def _get_so_libs(executable):
     return libs
 
 def _copy_binary_with_libs(src, dest_dir):
+    # type: (str, str) -> None
     """Copy a binary executable and all its dependant libraries.
 
     This does rely on the host file-system being fairly multi-arch
@@ -108,11 +120,13 @@ def _copy_binary_with_libs(src, dest_dir):
             _copy_with_mkdir(l , dest_dir, so_path)
 
 def _read_qemu_dockerfile(img_name):
+    # type: (str) -> str
     df = os.path.join(os.path.dirname(__file__), "dockerfiles",
                       img_name + ".docker")
     return open(df, "r").read()
 
 def _dockerfile_preprocess(df):
+    # type: (str) -> str
     out = ""
     for l in df.splitlines():
         if len(l.strip()) == 0 or l.startswith("#"):
@@ -194,11 +208,16 @@ class Docker(object):
         labels = json.loads(resp)[0]["Config"].get("Labels", {})
         return labels.get("com.qemu.dockerfile-checksum", "")
 
-    def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None, extra_files_cksum=[]):
-        if argv == None:
-            argv = []
-
+    def build_image(self,
+                    tag,                 # type: str
+                    docker_dir,          # type: str
+                    dockerfile,          # type: str
+                    quiet=True,          # type: bool
+                    user=False,          # type: bool
+                    argv=[],             # type: List[str]
+                    extra_files_cksum=[] # List[Tuple[str, bytes]]
+                    ):
+        # type(...) -> None
         tmp_df = tempfile.NamedTemporaryFile(dir=docker_dir, suffix=".docker")
         tmp_df.write(dockerfile)
 
@@ -249,7 +268,8 @@ class Docker(object):
 
 class SubCommand(object):
     """A SubCommand template base class"""
-    name = None # Subcommand name
+    # Subcommand name
+    name = None # type: str
     def shared_args(self, parser):
         parser.add_argument("--quiet", action="store_true",
                             help="Run quietly unless an error occured")
@@ -258,6 +278,7 @@ class SubCommand(object):
         """Setup argument parser"""
         pass
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         """Run command.
         args: parsed argument by argument parser.
         argv: remaining arguments from sys.argv.
@@ -271,6 +292,7 @@ class RunCommand(SubCommand):
         parser.add_argument("--keep", action="store_true",
                             help="Don't remove image when command completes")
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         return Docker().run(argv, args.keep, quiet=args.quiet)
 
 class BuildCommand(SubCommand):
@@ -294,6 +316,7 @@ class BuildCommand(SubCommand):
                             help="Dockerfile name")
 
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         dockerfile = open(args.dockerfile, "rb").read()
         tag = args.tag
 
@@ -321,7 +344,7 @@ class BuildCommand(SubCommand):
 
             # Copy any extra files into the Docker context. These can be
             # included by the use of the ADD directive in the Dockerfile.
-            cksum = []
+            cksum = []  # type: List[Tuple[bytes, str]]
             if args.include_executable:
                 # FIXME: there is no checksum of this executable and the linked
                 # libraries, once the image built any change of this executable
@@ -352,6 +375,7 @@ class UpdateCommand(SubCommand):
                             help="Executable to copy")
 
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         # Create a temporary tarball with our whole build context and
         # dockerfile for the update
         tmp = tempfile.NamedTemporaryFile(suffix="dckr.tar.gz")
@@ -394,6 +418,7 @@ class CleanCommand(SubCommand):
     """Clean up docker instances"""
     name = "clean"
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         Docker().clean()
         return 0
 
@@ -401,6 +426,7 @@ class ImagesCommand(SubCommand):
     """Run "docker images" command"""
     name = "images"
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         return Docker().command("images", argv, args.quiet)
 
 
@@ -409,6 +435,7 @@ class ProbeCommand(SubCommand):
     name = "probe"
 
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         try:
             docker = Docker()
             if docker._command[0] == "docker":
@@ -437,6 +464,7 @@ class CcCommand(SubCommand):
                             reading sources""")
 
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         if argv and argv[0] == "--":
             argv = argv[1:]
         cwd = os.getcwd()
@@ -468,6 +496,7 @@ class CheckCommand(SubCommand):
                             help="number of minutes")
 
     def run(self, args, argv):
+        # type: (argparse.Namespace, List[str]) -> int
         tag = args.tag
 
         dkr = Docker()
@@ -506,6 +535,7 @@ class CheckCommand(SubCommand):
         return 0
 
 def main():
+    # type: () -> int
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
     subparsers = parser.add_subparsers(title="subcommands", help=None)
-- 
2.18.0.rc1.1.g3f1ff2140
