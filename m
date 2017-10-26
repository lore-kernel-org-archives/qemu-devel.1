Received: from eggs.gnu.org ([2001:4830:134:3::10]:39863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iYQ-00028N-L1
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iYM-0002Pj-Jm
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iYM-0002PU-FW
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:50:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id 8so4352002qtv.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:50:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e4b4b545-919f-f043-6a6e-70e563fa75ff@amsat.org>
Date: Thu, 26 Oct 2017 10:50:26 -0300
MIME-Version: 1.0
In-Reply-To: <1509020054-25434-1-git-send-email-nanjekyejoannah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH WIP] replace numpy with struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joannah Nanjekye <nanjekyejoannah@gmail.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

Hi Joannah,

The common subject to use is [RFC PATCH] instead of [PATCH WIP]

On 10/26/2017 09:14 AM, Joannah Nanjekye wrote:
> This patch replaces the use of numpy with the standard Library struct module where possible.

This seems a good idea but why?
Do you have any performance improvements results to share?

> Signed-off-by: Joannah Nanjekye <nanjekyejoannah@gmail.com>
> ---
>  
>  scripts/analyze-migration.py | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 1455387..f421012 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -36,23 +36,28 @@ class MigrationFile(object):
>          self.file = open(self.filename, "rb")
>  
>      def read64(self):
> -        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i8')[0])
> +        buffer = file.read(64)
> +        return struct.unpack('>i16', buffer)[0]
>  
>      def read32(self):
> -        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i4')[0])
> +        buffer = file.read(32)
> +        return struct.unpack('>i8', buffer)[0]
>  
>      def read16(self):
> -        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i2')[0])
> +        buffer = file.read(16)
> +        return struct.unpack('>i4', buffer)[0]
>  
>      def read8(self):
> -        return np.asscalar(np.fromfile(self.file, count=1, dtype='>i1')[0])
> +        buffer = file.read(8)
> +        return struct.unpack('>i2', buffer)[0]
>  
>      def readstr(self, len = None):
> +        buffer = file.read(8)

^ move this

>          if len is None:
>              len = self.read8()
>          if len == 0:
>              return ""

here to avoid a read() if len=0

> -        return np.fromfile(self.file, count=1, dtype=('S%d' % len))[0]
> +        return np.array(struct.unpack(str(len) + 'd', buffer)[0])

Well this is now a mix of np + struct ...
This looks a bit more messy.

>  
>      def readvar(self, size = None):
>          if size is None:
> @@ -303,8 +308,8 @@ class VMSDFieldInt(VMSDFieldGeneric):
>  
>      def read(self):
>          super(VMSDFieldInt, self).read()
> -        self.sdata = np.fromstring(self.data, count=1, dtype=(self.sdtype))[0]
> -        self.udata = np.fromstring(self.data, count=1, dtype=(self.udtype))[0]
> +        self.sdata = np.array(struct.unpack(self.sdtype, self.data)[0])
> +        self.udata = np.array(struct.unpack(self.udtype, self.data)[0])

ditto.

>          self.data = self.sdata
>          return self.data

Regards,

Phil.
