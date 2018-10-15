Received: from eggs.gnu.org ([2001:4830:134:3::10]:43590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCB2o-0004Ln-B3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCB2j-0003Uy-1L
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:08:56 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCB2f-0003QG-JW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:08:51 -0400
Received: by mail-ed1-f43.google.com with SMTP id c26-v6so19363503edt.3
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:08:49 -0700 (PDT)
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-4-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21efbf04-c89b-c226-afbb-ec5adb42d65d@redhat.com>
Date: Tue, 16 Oct 2018 00:08:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Use Python byte strings where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 15/10/2018 16:14, Max Reitz wrote:
> Since byte strings are no longer the default in Python 3, we have to
> explicitly use them where we need to, which is mostly when working with
> structures.  It also means that we need to open a file in binary mode
> when we want to use structures.
> 
> On the other hand, we have to accomodate for the fact that some
> functions (still) work with byte strings but we want to use unicode
> strings (in Python 3 at least, and it does not matter in Python 2).
> This includes base64 encoding, but it is most notable when working with
> the subprocess module: Either we set univeral_newlines to True so that

'universal_newlines'

> the default streams are opened in text mode (hence this parameter is
> aliased as "text" as of 3.7), or, if that is not possible, we have to
> decode the output to a normal string.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  scripts/qtest.py                         |  2 +-
>  tests/qemu-iotests/044                   |  8 ++++----
>  tests/qemu-iotests/149                   |  8 +++++---
>  tests/qemu-iotests/207                   |  4 ++--
>  tests/qemu-iotests/iotests.py            | 11 +++++++----
>  tests/qemu-iotests/nbd-fault-injector.py |  4 ++--
>  tests/qemu-iotests/qcow2.py              | 10 +++++-----
>  7 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/scripts/qtest.py b/scripts/qtest.py
> index df0daf26ca..adf1fe3f26 100644
> --- a/scripts/qtest.py
> +++ b/scripts/qtest.py
> @@ -64,7 +64,7 @@ class QEMUQtestProtocol(object):
>  
>          @param qtest_cmd: qtest command text to be sent
>          """
> -        self._sock.sendall(qtest_cmd + "\n")
> +        self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
>  
>      def close(self):
>          self._sock.close()
> diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
> index 11ea0f4d35..69e736f687 100755
> --- a/tests/qemu-iotests/044
> +++ b/tests/qemu-iotests/044
> @@ -53,21 +53,21 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>              fd.seek(off_reftable)
>  
>              for i in xrange(0, h.refcount_table_clusters):
> -                sector = ''.join(struct.pack('>Q',
> +                sector = b''.join(struct.pack('>Q',
>                      off_refblock + i * 64 * 512 + j * 512)
>                      for j in xrange(0, 64))
>                  fd.write(sector)
>  
>              # Write the refcount blocks
>              assert(fd.tell() == off_refblock)
> -            sector = ''.join(struct.pack('>H', 1) for j in xrange(0, 64 * 256))
> +            sector = b''.join(struct.pack('>H', 1) for j in range(0, 64 * 256))
>              for block in xrange(0, h.refcount_table_clusters):
>                  fd.write(sector)
>  
>              # Write the L1 table
>              assert(fd.tell() == off_l1)
>              assert(off_l2 + 512 * h.l1_size == off_data)
> -            table = ''.join(struct.pack('>Q', (1 << 63) | off_l2 + 512 * j)
> +            table = b''.join(struct.pack('>Q', (1 << 63) | off_l2 + 512 * j)
>                  for j in xrange(0, h.l1_size))
>              fd.write(table)
>  
> @@ -85,7 +85,7 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>                  remaining = remaining - 1024 * 512
>                  off = off + 1024 * 512
>  
> -            table = ''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
> +            table = b''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
>                  for j in xrange(0, remaining / 512))
>              fd.write(table)
>  
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 9e0cad76f9..1225334cb8 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -79,7 +79,7 @@ class LUKSConfig(object):
>  
>      def first_password_base64(self):
>          (pw, slot) = self.first_password()
> -        return base64.b64encode(pw)
> +        return base64.b64encode(pw.encode('ascii')).decode('ascii')
>  
>      def active_slots(self):
>          slots = []
> @@ -98,7 +98,8 @@ def verify_passwordless_sudo():
>      proc = subprocess.Popen(args,
>                              stdin=subprocess.PIPE,
>                              stdout=subprocess.PIPE,
> -                            stderr=subprocess.STDOUT)
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
>  
>      msg = proc.communicate()[0]
>  
> @@ -116,7 +117,8 @@ def cryptsetup(args, password=None):
>      proc = subprocess.Popen(fullargs,
>                              stdin=subprocess.PIPE,
>                              stdout=subprocess.PIPE,
> -                            stderr=subprocess.STDOUT)
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
>  
>      msg = proc.communicate(password)[0]
>  
> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> index 444ae233ae..2d86a3da37 100755
> --- a/tests/qemu-iotests/207
> +++ b/tests/qemu-iotests/207
> @@ -109,7 +109,7 @@ with iotests.FilePath('t.img') as disk_path, \
>      md5_key = subprocess.check_output(
>          'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
>          'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
> -        shell=True).rstrip()
> +        shell=True).rstrip().decode('ascii')
>  
>      vm.launch()
>      blockdev_create(vm, { 'driver': 'ssh',
> @@ -147,7 +147,7 @@ with iotests.FilePath('t.img') as disk_path, \
>      sha1_key = subprocess.check_output(
>          'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
>          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
> -        shell=True).rstrip()
> +        shell=True).rstrip().decode('ascii')
>  
>      vm.launch()
>      blockdev_create(vm, { 'driver': 'ssh',
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 10f2d17419..7290c0b159 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -104,7 +104,8 @@ def qemu_img_pipe(*args):
>      '''Run qemu-img and return its output'''
>      subp = subprocess.Popen(qemu_img_args + list(args),
>                              stdout=subprocess.PIPE,
> -                            stderr=subprocess.STDOUT)
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
>      exitcode = subp.wait()
>      if exitcode < 0:
>          sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
> @@ -128,7 +129,8 @@ def qemu_io(*args):
>      '''Run qemu-io and return the stdout data'''
>      args = qemu_io_args + list(args)
>      subp = subprocess.Popen(args, stdout=subprocess.PIPE,
> -                            stderr=subprocess.STDOUT)
> +                            stderr=subprocess.STDOUT,
> +                            universal_newlines=True)
>      exitcode = subp.wait()
>      if exitcode < 0:
>          sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, ' '.join(args)))
> @@ -149,7 +151,8 @@ class QemuIoInteractive:
>          self.args = qemu_io_args + list(args)
>          self._p = subprocess.Popen(self.args, stdin=subprocess.PIPE,
>                                     stdout=subprocess.PIPE,
> -                                   stderr=subprocess.STDOUT)
> +                                   stderr=subprocess.STDOUT,
> +                                   universal_newlines=True)
>          assert self._p.stdout.read(9) == 'qemu-io> '
>  
>      def close(self):
> @@ -193,7 +196,7 @@ def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
>  
>  def create_image(name, size):
>      '''Create a fully-allocated raw image with sector markers'''
> -    file = open(name, 'w')
> +    file = open(name, 'wb')
>      i = 0
>      while i < size:
>          sector = struct.pack('>l504xl', i / 512, i / 512)
> diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
> index 439a090eb6..d45e2e0a6a 100755
> --- a/tests/qemu-iotests/nbd-fault-injector.py
> +++ b/tests/qemu-iotests/nbd-fault-injector.py
> @@ -86,7 +86,7 @@ def recvall(sock, bufsize):
>              raise Exception('unexpected disconnect')
>          chunks.append(chunk)
>          received += len(chunk)
> -    return ''.join(chunks)
> +    return b''.join(chunks)
>  
>  class Rule(object):
>      def __init__(self, name, event, io, when):
> @@ -177,7 +177,7 @@ def handle_connection(conn, use_export):
>          req = read_request(conn)
>          if req.type == NBD_CMD_READ:
>              write_reply(conn, 0, req.handle)
> -            conn.send('\0' * req.len, event='data')
> +            conn.send(b'\0' * req.len, event='data')
>          elif req.type == NBD_CMD_WRITE:
>              _ = conn.recv(req.len, event='data')
>              write_reply(conn, 0, req.handle)
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index b95a837759..b392972d1b 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -10,7 +10,7 @@ class QcowHeaderExtension:
>      def __init__(self, magic, length, data):
>          if length % 8 != 0:
>              padding = 8 - (length % 8)
> -            data += "\0" * padding
> +            data += b"\0" * padding
>  
>          self.magic  = magic
>          self.length = length
> @@ -103,7 +103,7 @@ class QcowHeader:
>  
>          fd.seek(self.header_length)
>          extensions = self.extensions
> -        extensions.append(QcowHeaderExtension(0, 0, ""))
> +        extensions.append(QcowHeaderExtension(0, 0, b""))
>          for ex in extensions:
>              buf = struct.pack('>II', ex.magic, ex.length)
>              fd.write(buf)
> @@ -137,8 +137,8 @@ class QcowHeader:
>          for ex in self.extensions:
>  
>              data = ex.data[:ex.length]
> -            if all(c in string.printable for c in data):
> -                data = "'%s'" % data
> +            if all(c in string.printable.encode('ascii') for c in data):
> +                data = "'%s'" % data.decode('ascii')
>              else:
>                  data = "<binary>"
>  
> @@ -178,7 +178,7 @@ def cmd_add_header_ext(fd, magic, data):
>          sys.exit(1)
>  
>      h = QcowHeader(fd)
> -    h.extensions.append(QcowHeaderExtension.create(magic, data))
> +    h.extensions.append(QcowHeaderExtension.create(magic, data.encode('ascii')))
>      h.update(fd)
>  
>  def cmd_add_header_ext_stdio(fd, magic):
> 
