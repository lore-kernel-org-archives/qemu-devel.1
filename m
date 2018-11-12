Received: from eggs.gnu.org ([2001:4830:134:3::10]:39965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMDMd-0007O4-WA
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMDMa-0000WJ-Lk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:38:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMDMa-0000UL-CE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:38:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so8804838wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:38:48 -0800 (PST)
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181109221213.7310-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6993de7-340f-848a-809b-2d07e2923fc7@redhat.com>
Date: Mon, 12 Nov 2018 15:38:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181109221213.7310-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] qemu-img: consider a zero number
 of I/O requests an invalid count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 9/11/18 23:12, Cleber Rosa wrote:
> It's debatable whether it makes sense to consider the bench command
> successful when no I/O requests will be performed.  This changes the
> behavior to consider a zero count of I/O requests an invalid value.
> While at it, avoid using signed types for number of I/O requests.
> 
> The image file used, is a simple raw image with 1K size.  There's a
> obvious trade off between creating and reusing those images.  This is
> an experiment in sharing those among tests.  It was created using:
> 
>   mkdir -p tests/data/images/empty
>   cd tests/data/images/empty
>   qemu-img create raw 1K
> 
> This relies on the Test's "get_data()", which by default looks for
> data files on sources that map to various levels of specificity of a
> test: file, test and additionally with variant and a symlink.
> 
> One other possibility with regards to in-tree images, is to extend the
> Test's "get_data()" API (which is extensible by design) and make the
> common images directory a "source".  The resulting API usage would be
> similar to:
> 
>     self.get_data("empty/raw", source="common_images")
> 
> or simply:
> 
>     self.get_data("empty/raw")
> 
> To look for "empty/raw" in any of the available sources.  That would
> make the symlink unnecessary.
> 
> Reference: https://avocado-framework.readthedocs.io/en/65.0/api/core/avocado.core.html#avocado.core.test.TestData
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   qemu-img.c                                  |   8 ++---
>   tests/acceptance/qemu_img_bench.py          |  34 ++++++++++++++++++++
>   tests/acceptance/qemu_img_bench.py.data/img |   1 +
>   tests/data/images/empty/raw                 | Bin 0 -> 1024 bytes
>   4 files changed, 39 insertions(+), 4 deletions(-)
>   create mode 100644 tests/acceptance/qemu_img_bench.py
>   create mode 120000 tests/acceptance/qemu_img_bench.py.data/img
>   create mode 100644 tests/data/images/empty/raw
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 4c96db7ba4..7ffcdd1589 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3960,7 +3960,7 @@ typedef struct BenchData {
>       int bufsize;
>       int step;
>       int nrreq;
> -    int n;
> +    unsigned int n;
>       int flush_interval;
>       bool drain_on_flush;
>       uint8_t *buf;
> @@ -4051,7 +4051,7 @@ static int img_bench(int argc, char **argv)
>       bool quiet = false;
>       bool image_opts = false;
>       bool is_write = false;
> -    int count = 75000;
> +    unsigned int count = 75000;
>       int depth = 64;
>       int64_t offset = 0;
>       size_t bufsize = 4096;
> @@ -4098,7 +4098,7 @@ static int img_bench(int argc, char **argv)
>           {
>               unsigned long res;
>   
> -            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
> +            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > UINT_MAX || res <= 0) {

res is unsigned so can't be < 0.

>                   error_report("Invalid request count specified");
>                   return 1;
>               }
> @@ -4248,7 +4248,7 @@ static int img_bench(int argc, char **argv)
>           .flush_interval = flush_interval,
>           .drain_on_flush = drain_on_flush,
>       };
> -    printf("Sending %d %s requests, %d bytes each, %d in parallel "
> +    printf("Sending %u %s requests, %d bytes each, %d in parallel "
>              "(starting at offset %" PRId64 ", step size %d)\n",
>              data.n, data.write ? "write" : "read", data.bufsize, data.nrreq,
>              data.offset, data.step);
> diff --git a/tests/acceptance/qemu_img_bench.py b/tests/acceptance/qemu_img_bench.py
> new file mode 100644
> index 0000000000..327524ad8f
> --- /dev/null
> +++ b/tests/acceptance/qemu_img_bench.py
> @@ -0,0 +1,34 @@
> +# Test for the basic qemu-img bench command
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import QemuImgTest
> +from avocado.utils import process
> +
> +
> +class Bench(QemuImgTest):
> +    """
> +    Runs the qemu-img tool with the bench command and different
> +    options and verifies the expected outcome.
> +
> +    :avocado: enable
> +    """
> +    def check_invalid_count(self, count):
> +        cmd = "%s bench -c %d %s" % (self.qemu_img_bin, count, self.get_data("img"))
> +        result = process.run(cmd, ignore_status=True)
> +        self.assertEqual(1, result.exit_status)
> +        self.assertIn(b"Invalid request count", result.stderr)
> +
> +    def test_zero_count(self):
> +        self.check_invalid_count(0)
> +
> +    def test_negative_count(self):
> +        self.check_invalid_count(-1)
> diff --git a/tests/acceptance/qemu_img_bench.py.data/img b/tests/acceptance/qemu_img_bench.py.data/img
> new file mode 120000
> index 0000000000..6d01ef2e85
> --- /dev/null
> +++ b/tests/acceptance/qemu_img_bench.py.data/img
> @@ -0,0 +1 @@
> +../../data/images/empty/raw
> \ No newline at end of file
> diff --git a/tests/data/images/empty/raw b/tests/data/images/empty/raw
> new file mode 100644
> index 0000000000000000000000000000000000000000..06d7405020018ddf3cacee90fd4af10487da3d20
> GIT binary patch
> literal 1024
> ScmZQz7zLvtFd70QH3R?z00031
> 
> literal 0
> HcmV?d00001
> 
