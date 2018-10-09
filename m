Received: from eggs.gnu.org ([2001:4830:134:3::10]:35235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wYi-0007eA-EG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wYe-00017G-Iu
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:16:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9wYe-000170-BR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:16:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id e4-v6so2887319wrs.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 11:16:36 -0700 (PDT)
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-4-crosa@redhat.com>
	<75560722-a9f5-5ec9-b851-d521960ed8eb@redhat.com>
	<d56ed2c4-d310-5048-3c02-682cf2934f85@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d56ed2c4-d310-5048-3c02-682cf2934f85@redhat.com>
Date: Tue, 09 Oct 2018 19:16:33 +0100
Message-ID: <874ldvm1dq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] Travis support for the acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Cleber Rosa <crosa@redhat.com> writes:

> On 10/9/18 9:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Cleber,
>>
>> On 09/10/2018 06:18, Cleber Rosa wrote:
>>> This enables the execution of the acceptance tests on Travis.
>>
>> Did you test this? =3D)
>>
>
> I did have some jobs on Travis that looked promising.  But yeah, later I
> found some issues. :/
>
>>>
>>> Because the Travis environment is based on Ubuntu Trusty, it requires
>>> the python3-pip.
>>>
>>> Note: while another supposedely required component on newer versions
>>> (such as on Bionic) split the Python 3 installation further on the
>>> python3-venv package.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  .travis.yml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 95be6ec59f..db1a31ea51 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -36,6 +36,7 @@ addons:
>>>        - liburcu-dev
>>>        - libusb-1.0-0-dev
>>>        - libvte-2.90-dev
>>> +      - python3-pip
>>>        - sparse
>>>        - uuid-dev
>>>        - gcovr
>>> @@ -117,6 +118,11 @@ matrix:
>>>      - env: CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>>        python:
>>>          - "3.6"
>>> +    # Acceptance (Functional) tests
>>> +    - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu"
>>> +           TEST_CMD=3D"make check-acceptance"
>>> +      python:
>>> +        - "3.6"
>>>      # Using newer GCC with sanitizers
>>>      - addons:
>>>          apt:
>>>
>>
>> Using the following patch:
>>
>> -- >8 --
>> diff --git a/.travis.yml b/.travis.yml
>> index 95be6ec59f..87e0c9a13f 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -118,4 +118,15 @@ matrix:
>>        python:
>>          - "3.6"
>> +    # Acceptance (Functional) tests
>> +    - env: CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu"
>> +           TEST_CMD=3D"make check-acceptance"
>> +           # sudo rm /usr/local/bin/pip*
>> +      python:
>> +        - "3.6"
>> +      addons:
>> +        apt:
>> +          packages:
>> +            - python3-pip
>> +            - python3.4-venv
>
> This patch revealed to me that, even though we're asking Travis for a
> Python 3.6 stack, we're manually pointing to the primary Python (3.4)
> installation.  This is in itself a source of problems.
>
> Read on...
>
>>      # Using newer GCC with sanitizers
>>      - addons:
>> ---
>>
>> I got some improvements until:
>>
>>   VENV    /home/travis/build/philmd/qemu/tests/venv
>>   MKDIR   /home/travis/build/philmd/qemu/tests/results
>>   PIP     /home/travis/build/philmd/qemu/tests/venv-requirements.txt
>> Exception:
>> Traceback (most recent call last):
>>   File "/usr/lib/python3/dist-packages/pip/basecommand.py", line 122, in
>> main
>>     status =3D self.run(options, args)
>>   File "/usr/lib/python3/dist-packages/pip/commands/install.py", line
>> 283, in run
>>     requirement_set.install(install_options, global_options,
>> root=3Doptions.root_path)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 1436, in install
>>     requirement.install(install_options, global_options, *args, **kwargs)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 672, in install
>>     self.move_wheel_files(self.source_dir, root=3Droot)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 902, in
>> move_wheel_files
>>     pycompile=3Dself.pycompile,
>>   File "/usr/lib/python3/dist-packages/pip/wheel.py", line 206, in
>> move_wheel_files
>>     clobber(source, lib_dir, True)
>>   File "/usr/lib/python3/dist-packages/pip/wheel.py", line 193, in clobb=
er
>>     os.makedirs(destsubdir)
>>   File "/usr/lib/python3.4/os.py", line 237, in makedirs
>>     mkdir(name, mode)
>> PermissionError: [Errno 13] Permission denied:
>> '/usr/local/lib/python3.4/dist-packages/avocado'
>>
>
> This looks to me like it's caused by the use of the system wide Python
> 3.4 installation, as mentioned above.  That, and possibly the
> "--system-wide-packages" flag to the venv.
>
> So, in order to understand if, in those environments, we should let
> "configure" pick up the right Python, I did the following experiment:
>
>  $ python3 -m venv /tmp/py3-build
>  $ . /tmp/py3-build/bin/activate
>  $ which python
>  /tmp/py3-build/bin/python
>  $ /tmp/py3-build/bin/python --version
>  Python 3.6.6
>
> This shows that when a venv is activated, the "right" Python should be
> available in the $PATH.  So, building QEMU without pointint to a
> specific Python binary (when inside a venv) gives you:
>
>  $ mkdir -p /tmp/qemu-build
>  $ cd /tmp/qemu-build
>  $ ~/src/qemu/configure --target-list=3D"x86_64-softmmu"
>  $ make print-PYTHON
>  PYTHON=3Dpython -B
>  $ which python
>  /tmp/py3-build/bin/python
>
> The whole question now is how/where Travis puts the requested Python
> version (python: - "3.6").  Is it on a venv?  Is it on a specific
> location? Is that reliable enough?
>
> I'm going to look for those answers now.

You can experiment with the Travis environment on your own system using:

  make docker-test-build@travis DEBUG=3D1

>
> - Cleber.
>
>> See: https://travis-ci.org/philmd/qemu/jobs/439138706
>>


--
Alex Benn=C3=A9e
