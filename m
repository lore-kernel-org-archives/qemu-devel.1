Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fO5PQ-0001dG-6i
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fO5PN-00046K-5E
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fO5PM-00044W-Tj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:01:13 -0400
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
	<20180530125705.GL14623@stefanha-x1.localdomain>
	<20180530162949.GE7451@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <47189c37-afec-6366-e9e4-cae5999d9eb2@redhat.com>
Date: Wed, 30 May 2018 14:00:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180530162949.GE7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>



On 05/30/2018 12:29 PM, Eduardo Habkost wrote:
> On Wed, May 30, 2018 at 01:57:05PM +0100, Stefan Hajnoczi wrote:
>> On Tue, May 29, 2018 at 03:37:28PM -0400, Cleber Rosa wrote:
>>> This patch adds a few simple behavior tests for VNC.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  tests/acceptance/vnc.py | 60 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644 tests/acceptance/vnc.py
>>>
>>> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
>>> new file mode 100644
>>> index 0000000000..b1ef9d71b1
>>> --- /dev/null
>>> +++ b/tests/acceptance/vnc.py
>>> @@ -0,0 +1,60 @@
>>> +# Simple functional tests for VNC functionality
>>> +#
>>> +# Copyright (c) 2018 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#  Cleber Rosa <crosa@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +from avocado_qemu import Test
>>> +
>>> +
>>> +class Vnc(Test):
>>> +    """
>>> +    :avocado: enable
>>> +    :avocado: tags=vnc,quick
>>> +    """
>>> +    def test_no_vnc(self):
>>> +        self.vm.add_args('-nodefaults', '-S')
>>> +        self.vm.launch()
>>
>> If this pattern becomes very common maybe vm.launch() should become
>> vm.launch(*extra_args) to make this a one-liner:
>>
>>   self.vm.launch('-nodefaults', '-S')
> 
> I think this was suggested in the past:
> 
>   self.vm.add_args(...).launch()
> 
> This style would be useful if we add other methods that change
> QEMU options in addition to raw add_args().  e.g.:
> 
>   self.vm.add_args(...).add_console(...).add_drive(...).launch()
> 

Yes, this is an old discussion indeed.  IMO, method chaining can look
attractive at first, but it will quickly bring a few new issues to be
dealt with.

For once, it brings the assumption that it can be done for all methods.
 Using the previous example I'd expect to be able to do:

   self.vm.add_args(...).launch(...).migrate(...).shutdown()

Which seems fine, but now the code is plagued with "return self" statements.

Then, code style and indentation questions will quickly arise.  Either this:

   self.vm.add_args('-nodefaults', '-S').add_console('isa-serial') \
          .add_drive(file='/path/to/file, format='raw').launch() \
          .shutdown()

Or this:

   (self.vm.add_args('-nodefaults', '-S').add_console('isa-serial')
           .add_drive(file='/path/to/file, format='raw').launch()
           .shutdown())

Looks just as bad to me.  The non-method chaining syntax would look like:

   self.vm.add_args('-nodefaults', '-S')
   self.vm.add_console('isa-serial')
   self.vm.add_drive(file='/path/to/file, format='raw')
   self.vm.launch()
   self.vm.shutdown()

Or even:

   with self.vm as vm:
      vm.add_args('-nodefaults', '-S')
      vm.add_console('isa-serial')
      vm.add_drive(file='/path/to/file, format='raw')
      vm.launch()
   # shutdown() called on __exit__()

Which IMO, are superior in readability and clarity.  This is a matter of
choosing a style, so that we can expect (demand?) that tests follow it.

I'm certainly less experienced with the project dynamics than most here,
so I'm strongly hoping for your input to quickly define the code style
to be used here.

Because of that, I'll skip changing anything here on v4.

- Cleber.
