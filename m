Received: from eggs.gnu.org ([2001:4830:134:3::10]:34684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDFji-0000N6-Uy
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDFjb-0000xm-R6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDFjb-0000ue-9E
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:21:35 -0400
References: <20181018162057.19348-1-wainersm@redhat.com>
	<1444866c-59e1-1ef9-b137-b0607f34d219@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <43272669-34e5-58aa-2898-331b4ce0c8a6@redhat.com>
Date: Thu, 18 Oct 2018 17:21:27 -0400
MIME-Version: 1.0
In-Reply-To: <1444866c-59e1-1ef9-b137-b0607f34d219@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ccarrara@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, philmd@redhat.com, lizhijian@cn.fujitsu.com



On 10/18/18 3:11 PM, Caio Carrara wrote:
> Hi Wainer,
> 
> On 18-10-2018 13:20, Wainer dos Santos Moschetta wrote:
>> [...]
>> +    def test_with_2GB_file_should_exit_error_msg(self):
>> +        """
>> +        Pretends to boot QEMU with an initrd file with size of 2GB
>> +        and expect it exits with error message.
>> +        Regression test for bug fixed on commit f3839fda5771596152.
>> +        """
>> +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>> +                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
>> +        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> +
>> +        with tempfile.NamedTemporaryFile() as initrd:
>> +            initrd.seek(2048*(1024**2) -1)
>> +            initrd.write(b'\0')
>> +            initrd.flush()
>> +            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
>> +                                                initrd.name)
>> +            res = run(cmd, ignore_status=True)
>> +            self.assertNotEqual(res.exit_status, 0)
>> +            expected_msg = r'.*initrd is too large.*max: \d+, need \d+.*'
>> +            self.assertRegex(res.stderr_text, expected_msg)
>>
> 
> At least on my run this test is the first one to fail (with error) due
> Python version (on Py2 there's no assertRegex method). AFIK we're moving
> towards only Py3 support on the acceptance tests, right? The current
> behavior (error) is the expected?
> 

We have verbalized and agreed on that indeed.  Wainer, can you please
add a simple line in the acceptance tests documentation mentioning that?

- Cleber.

> Since the comment above is just for clarification and not a blocking issue:
> 
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Tested-by: Caio Carrara <ccarrara@redhat.com>
> 
