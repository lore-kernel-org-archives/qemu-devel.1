Received: from eggs.gnu.org ([2001:4830:134:3::10]:44588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLAM1-0004kt-26
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLALx-0000Dj-7h
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:37:09 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLALx-0000DN-1Q
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:37:05 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so593255qtb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:37:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
	<937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
Date: Wed, 14 Jun 2017 12:37:00 -0300
MIME-Version: 1.0
In-Reply-To: <937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org, Fam Zheng <famz@redhat.com>

On 06/14/2017 12:07 PM, Paolo Bonzini wrote:
>
>
> On 14/06/2017 05:52, Philippe Mathieu-Daudé wrote:
>> As you said, due to Travis using Ubuntu still not all libs get detected
>> but at least the following:
>>
>>  $ ./configure ${CONFIG}
>> -VirtFS support    no
>> +VirtFS support    yes
>> -bluez  support    no
>> +bluez  support    yes
>> -xfsctl support    no
>> +xfsctl support    yes
>> -lzo support       no
>> +lzo support       yes
>> -snappy support    no
>> +snappy support    yes
>>
>> Using debian based docker images on Shippable we also get:
>>
>> -nettle            no
>> -nettle kdf        no
>> +nettle            yes (3.3)
>> +nettle kdf        yes
>> -rbd support       no
>> +rbd support       yes
>> -vde support       no
>> +vde support       yes
>> -GlusterFS support no
>> +GlusterFS support yes
>> -libnfs support    no
>> +libnfs support    yes
>
> So this leaves out only rdma and iscsi?
>
> I don't know travis vs. shippable very well, can you provide a similar
> patch to shippable?

Travis base images are Ubuntu based, as said Peter "some of our 
dependencies need versions that are closer to the bleeding edge than 
those distros provide".
With Shippable we can use our own docker images, i.e. for 
cross-compiling we use debian/stable.

I already provided a branch doing that on Shippable reviewed by Alex/Fam:
https://github.com/philmd/qemu/tree/docker_shippable_v5
I believe it is in Fam's queue.

You can check output here:

https://app.shippable.com/github/philmd/qemu/runs/78/1/console

   ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
   target list       arm-softmmu arm-linux-user armeb-linux-user
   ...
   RDMA support      yes
   ...
   libiscsi support  yes

>
> Paolo
>
>> On 06/13/2017 12:54 PM, Peter Maydell wrote:
>>> Update the travis list of library packages to install so that
>>> our build tests cover more of our code base.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>>> ---
>>>  .travis.yml | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 27a2d9c..26dabb6 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -11,28 +11,37 @@ addons:
>>>        # Build dependencies
>>>        - libaio-dev
>>>        - libattr1-dev
>>> +      - libbluetooth-dev
>>>        - libbrlapi-dev
>>> +      - libcap-dev
>>>        - libcap-ng-dev
>>>        - libgnutls-dev
>>>        - libgtk-3-dev
>>>        - libiscsi-dev
>>>        - liblttng-ust-dev
>>> +      - liblzo2-dev
>>>        - libnfs-dev
>>>        - libncurses5-dev
>>>        - libnss3-dev
>>>        - libpixman-1-dev
>>>        - libpng12-dev
>>>        - librados-dev
>>> +      - librdmacm-dev
>>>        - libsdl1.2-dev
>>>        - libseccomp-dev
>>> +      - libsnappy-dev
>>>        - libspice-protocol-dev
>>>        - libspice-server-dev
>>>        - libssh2-1-dev
>>>        - liburcu-dev
>>>        - libusb-1.0-0-dev
>>> +      - libvde-dev
>>>        - libvte-2.90-dev
>>> +      - libxen-dev
>>> +      - nettle-dev
>>>        - sparse
>>>        - uuid-dev
>>> +      - xfslibs-dev
>>>
>>>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
>>>  # to prevent IRC notifications from forks. This was created using:
>>> @@ -162,28 +171,37 @@ matrix:
>>>              # Build dependencies
>>>              - libaio-dev
>>>              - libattr1-dev
>>> +            - libbluetooth-dev
>>>              - libbrlapi-dev
>>> +            - libcap-dev
>>>              - libcap-ng-dev
>>>              - libgnutls-dev
>>>              - libgtk-3-dev
>>>              - libiscsi-dev
>>>              - liblttng-ust-dev
>>> +            - liblzo2-dev
>>>              - libnfs-dev
>>>              - libncurses5-dev
>>>              - libnss3-dev
>>>              - libpixman-1-dev
>>>              - libpng12-dev
>>>              - librados-dev
>>> +            - librdmacm-dev
>>>              - libsdl1.2-dev
>>>              - libseccomp-dev
>>> +            - libsnappy-dev
>>>              - libspice-protocol-dev
>>>              - libspice-server-dev
>>>              - libssh2-1-dev
>>>              - liburcu-dev
>>>              - libusb-1.0-0-dev
>>> +            - libvde-dev
>>>              - libvte-2.90-dev
>>> +            - libxen-dev
>>> +            - nettle-dev
>>>              - sparse
>>>              - uuid-dev
>>> +            - xfslibs-dev
>>>        language: generic
>>>        compiler: none
>>>        env:
>>>
>
