Received: from eggs.gnu.org ([2001:4830:134:3::10]:43401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9sux-0007ki-Il
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9sun-0005dh-6i
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:19 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9sun-0005dJ-01
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:23:13 -0400
Received: by mail-wr1-f44.google.com with SMTP id d2-v6so2049251wro.7
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:23:12 -0700 (PDT)
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-4-crosa@redhat.com>
	<75560722-a9f5-5ec9-b851-d521960ed8eb@redhat.com>
	<87k1mrmcj9.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <afe5f97d-d519-35a4-d11a-3cc2be31dc33@redhat.com>
Date: Tue, 9 Oct 2018 16:23:09 +0200
MIME-Version: 1.0
In-Reply-To: <87k1mrmcj9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 09/10/2018 16:15, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Hi Cleber,
>>
>> On 09/10/2018 06:18, Cleber Rosa wrote:
>>> This enables the execution of the acceptance tests on Travis.
>>
>> Did you test this? =)
>>
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
>>>      - env: CONFIG="--target-list=x86_64-softmmu"
>>>        python:
>>>          - "3.6"
>>> +    # Acceptance (Functional) tests
>>> +    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
>>> +           TEST_CMD="make check-acceptance"
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
>> +    - env: CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu"
>> +           TEST_CMD="make check-acceptance"
>> +           # sudo rm /usr/local/bin/pip*
> 
> That snuck in ^

=)

Travis-ci image comes with this version which is Python2.

>> +      python:
>> +        - "3.6"
>> +      addons:
>> +        apt:
>> +          packages:
>> +            - python3-pip
>> +            - python3.4-venv
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
>>     status = self.run(options, args)
>>   File "/usr/lib/python3/dist-packages/pip/commands/install.py", line
>> 283, in run
>>     requirement_set.install(install_options, global_options,
>> root=options.root_path)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 1436, in install
>>     requirement.install(install_options, global_options, *args, **kwargs)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 672, in install
>>     self.move_wheel_files(self.source_dir, root=root)
>>   File "/usr/lib/python3/dist-packages/pip/req.py", line 902, in
>> move_wheel_files
>>     pycompile=self.pycompile,
>>   File "/usr/lib/python3/dist-packages/pip/wheel.py", line 206, in
>> move_wheel_files
>>     clobber(source, lib_dir, True)
>>   File "/usr/lib/python3/dist-packages/pip/wheel.py", line 193, in clobber
>>     os.makedirs(destsubdir)
>>   File "/usr/lib/python3.4/os.py", line 237, in makedirs
>>     mkdir(name, mode)
>> PermissionError: [Errno 13] Permission denied:
>> '/usr/local/lib/python3.4/dist-packages/avocado'
>>
>> See: https://travis-ci.org/philmd/qemu/jobs/439138706
> 
> Don't we need to do a pip install or is avocado already included?

Yes I think we do. This is why I asked Cleber on patch #1 of this series
why he choose to use "venv ... --system-site-packages".
