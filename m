Received: from eggs.gnu.org ([2001:4830:134:3::10]:36625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fO5cw-0004RF-JH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fO5cr-0005xN-K8
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fO5cr-0005x9-Ew
	for qemu-devel@nongnu.org; Wed, 30 May 2018 14:15:09 -0400
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-2-crosa@redhat.com>
	<20180530125421.GJ14623@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <76cb5c01-fab1-c846-58ad-b05bf8d59ef9@redhat.com>
Date: Wed, 30 May 2018 14:15:07 -0400
MIME-Version: 1.0
In-Reply-To: <20180530125421.GJ14623@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] Add functional/acceptance tests
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>



On 05/30/2018 08:54 AM, Stefan Hajnoczi wrote:
> On Tue, May 29, 2018 at 03:37:26PM -0400, Cleber Rosa wrote:
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 0ca1a2d4b5..5e090c87fb 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -484,3 +484,156 @@ supported. To start the fuzzer, run
>>  
>>  Alternatively, some command different from "qemu-img info" can be tested, by
>>  changing the ``-c`` option.
>> +
>> +Acceptance tests using the Avocado Framework
>> +============================================
>> +
>> +The ``tests/acceptance`` directory hosts functional tests, also known
>> +as acceptance level tests.  They're usually higher level, and may
>> +interact with external resources and with various guest operating
>> +systems.
> 
> Can you give more concrete examples of what acceptance tests do?  This
> will make it easier for readers to understand where Avocado fits in.
> 
> Things that come to mind: checking the behavior of QMP commands and
> guest OS commands.
> 

Sure.  How about:

---

Tests based on ``avocado_qemu.Test`` can easily:

 * Customize the command line arguments given to the convenience
   ``self.vm`` attribute (a QEMUMachine instance)

 * Interact with the QEMU monitor, send QMP commands and check
   their results

 * Interact with the guest OS, using the convenience console device
   (which may be useful to assert the effectiveness and correctness of
   command line arguments or QMP commands)

 * Interact with external data files that accompany the test itself
   (see ``avocado.Test.get_data()``)

 * Donwload (and cache) remote data files such as firmware and kernel
   images

 * Have access to a library of guest OS images (by means of the
   ``avocado.utils.vmimage`` library)

 * Make use of various other test related utilities available at the
   test class itself and at the utility library:

   -
http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
   -
http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html


---

>> +To run all tests in the current directory, tagged in a particular way,
>> +run:
>> +
>> +.. code::
>> +
>> +  avocado run -t <TAG> .
> 
> What is TAG?  I guess this identifies a subset of tests to run?
> 

I'm trying to avoid too many references to the Avocado documentation, so
this could become:

---

Tests may be classified according to a convention by using docstring
directives such as ``:avocado: tags=TAG1,TAG2``.  To run all tests
in the current directory, tagged as "quick", run:

.. code::

  avocado run -t quick .

---

>> +QEMUMachine
>> +~~~~~~~~~~~
>> +
>> +The QEMUMachine API should be somewhat familiar to QEMU hackers.  It's
>> +used in the Python iotests, device-crash-test and other Python scripts.
> 
> This is not useful to someone who isn't a QEMU hacker :).
> 

True... so I would ask, why are they wandering around here? :D

Now, seriously, I'll add a bit of extra info here on v4.

> Please explain that QEMUMachine is a class for controlling a QEMU
> instance, including command-line arguments and monitor commands/events.
> 

Sure thing.

- Cleber.
