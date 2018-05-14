Received: from eggs.gnu.org ([2001:4830:134:3::10]:39149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFVx-00036K-TM
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFVw-00055i-8a
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:35:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-11-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96ffe205-a582-4fe2-29c7-0858dd8b3488@amsat.org>
Date: Mon, 14 May 2018 12:35:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180511222052.8734-11-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 10/10] python: futurize -f
 lib2to3.fixes.fix_numliterals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On 05/11/2018 07:20 PM, Eduardo Habkost wrote:
> Convert octal literals into the new syntax.
> 
> This is necessary for Python 3 compatibility.
> 
> Done using:
> 
>   $ py=$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f lib2to3.fixes.fix_numliterals $py
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qmp/qom-fuse   |  6 +++---
>  tests/qemu-iotests/118 | 24 ++++++++++++------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
> index b00cb0a0af..e524e798fc 100755
> --- a/scripts/qmp/qom-fuse
> +++ b/scripts/qmp/qom-fuse
> @@ -90,7 +90,7 @@ class QOMFS(Fuse):
>  
>      def getattr(self, path):
>          if self.is_link(path):
> -            value = posix.stat_result((0755 | stat.S_IFLNK,
> +            value = posix.stat_result((0o755 | stat.S_IFLNK,
>                                         self.get_ino(path),
>                                         0,
>                                         2,
> @@ -101,7 +101,7 @@ class QOMFS(Fuse):
>                                         0,
>                                         0))
>          elif self.is_object(path):
> -            value = posix.stat_result((0755 | stat.S_IFDIR,
> +            value = posix.stat_result((0o755 | stat.S_IFDIR,
>                                         self.get_ino(path),
>                                         0,
>                                         2,
> @@ -112,7 +112,7 @@ class QOMFS(Fuse):
>                                         0,
>                                         0))
>          elif self.is_property(path):
> -            value = posix.stat_result((0644 | stat.S_IFREG,
> +            value = posix.stat_result((0o644 | stat.S_IFREG,
>                                         self.get_ino(path),
>                                         0,
>                                         1,
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index a0469b570e..ff3b2ae3e7 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -390,14 +390,14 @@ class TestChangeReadOnly(ChangeBaseClass):
>  
>      def tearDown(self):
>          self.vm.shutdown()
> -        os.chmod(old_img, 0666)
> -        os.chmod(new_img, 0666)
> +        os.chmod(old_img, 0o666)
> +        os.chmod(new_img, 0o666)
>          os.remove(old_img)
>          os.remove(new_img)
>  
>      def test_ro_ro_retain(self):
> -        os.chmod(old_img, 0444)
> -        os.chmod(new_img, 0444)
> +        os.chmod(old_img, 0o444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -417,7 +417,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>  
>      def test_ro_rw_retain(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -437,7 +437,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>  
>      def test_rw_ro_retain(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -459,7 +459,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
>  
>      def test_ro_rw(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -480,7 +480,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>  
>      def test_rw_ro(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -521,7 +521,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>  
>      def test_make_ro_rw(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -542,7 +542,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
>  
>      def test_make_rw_ro_by_retain(self):
> -        os.chmod(old_img, 0444)
> +        os.chmod(old_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk,read-only=on', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -562,7 +562,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>  
>      def test_make_ro_rw_by_retain(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> @@ -582,7 +582,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>          self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
>  
>      def test_rw_ro_cycle(self):
> -        os.chmod(new_img, 0444)
> +        os.chmod(new_img, 0o444)
>          self.vm.add_drive(old_img, 'media=disk', 'none')
>          self.vm.add_device('floppy,drive=drive0,id=%s' % self.device_name)
>          self.vm.launch()
> 
