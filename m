Received: from eggs.gnu.org ([209.51.188.92]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsl4-0002mO-Jc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsl2-0006hi-5Z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsl1-0006gh-VU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so26552379wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:54:11 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-6-crosa@redhat.com>
	<20190118142830.GB24013@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef455369-493b-2b8a-26ae-b4be3f820a0a@redhat.com>
Date: Tue, 22 Jan 2019 10:54:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190118142830.GB24013@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/18] Acceptance tests: introduce arch
 parameter and attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On 1/18/19 3:28 PM, Caio Carrara wrote:
> Hi, Cleber.
> 
> On Thu, Jan 17, 2019 at 01:56:15PM -0500, Cleber Rosa wrote:
>> It's useful to define the architecture that should be used in
>> situations such as:
>>  * the intended target of the QEMU binary to be used on tests
>>  * the architecture of code to be run within the QEMU binary, such
>>    as a kernel image or a full blown guest OS image
>>
>> This commit introduces both a test parameter and a test instance
>> attribute, that will contain such a value.
>>
>> Now, when the "arch" test parameter is given, it will influence the
>> selection of the default QEMU binary, if one is not given explicitly
>> by means of the "qemu_img" parameter.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  docs/devel/testing.rst                    | 18 ++++++++++++++++++
>>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 44c9b3ae74..60a16c5834 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -689,6 +689,17 @@ vm
>>  A QEMUMachine instance, initially configured according to the given
>>  ``qemu_bin`` parameter.
>>  
>> +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different
>> +scenarios.  For instance, when a QEMU binary is not explicitly given,
>> +the one selected will depend on this attribute.
>> +
>> +The ``arch`` attribute will be set to the test parameter of the same
>> +name, and if one is not given explicitly, it will default to the
>> +system architecture (as given by ``uname``).
> 
> Would you think it's important to make explicit that it's the *host*
> system architecture? Just like you did in the docstrings of
> pick_default_qemu_bin().

Agreed.

> 
>> +
>>  qemu_bin
>>  ~~~~~~~~
>>  
>> @@ -711,6 +722,13 @@ like the following:
>>  
>>    PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
>>  
>> +arch
>> +~~~~
>> +
>> +The architecture that will be used on a number of different scenarios.
>> +This parameter has a direct relation with the ``arch`` attribute.  If
>> +not given, it will default to None.
>> +
>>  qemu_bin
>>  ~~~~~~~~
>>  
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
>> index d8d5b48dac..7a38851753 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -23,16 +23,22 @@ def is_readable_executable_file(path):
>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>>  
>>  
>> -def pick_default_qemu_bin():
>> +def pick_default_qemu_bin(arch=None):
>>      """
>>      Picks the path of a QEMU binary, starting either in the current working
>>      directory or in the source tree root directory.
>>  
>> +    :param arch: the arch to use when looking for a QEMU binary (the target
>> +                 will match the arch given).  If None (the default) arch
>> +                 will be the current host system arch (as given by
>> +                 :func:`os.uname`).

\o/ thanks :)

>> +    :type arch: str
>>      :returns: the path to the default QEMU binary or None if one could not
>>                be found
>>      :rtype: str or None
>>      """
>> -    arch = os.uname()[4]
>> +    if arch is None:
>> +        arch = os.uname()[4]
>>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>>                                            "qemu-system-%s" % arch)
>>      if is_readable_executable_file(qemu_bin_relative_path):
>> @@ -47,8 +53,9 @@ def pick_default_qemu_bin():
>>  class Test(avocado.Test):
>>      def setUp(self):
>>          self.vm = None
>> +        self.arch = self.params.get('arch')
>>          self.qemu_bin = self.params.get('qemu_bin',
>> -                                        default=pick_default_qemu_bin())
>> +                                        default=pick_default_qemu_bin(self.arch))
> 
> Since it was used the named argument in function declaration I think
> it's more consistent also use the argument name here in the function
> call: `pick_default_qemu_bin(arch=self.arch)`

With Caio's comments addressed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>>          if self.qemu_bin is None:
>>              self.cancel("No QEMU binary defined or found in the source tree")
>>          self.vm = QEMUMachine(self.qemu_bin)
>> -- 
>> 2.20.1
>>
> 
> Thanks,
> 
