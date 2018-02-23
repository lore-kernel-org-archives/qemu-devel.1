Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH2c-0006iv-7x
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epH2Z-0007SG-FQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epH2Z-0007RC-BM
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:21:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-10-armbru@redhat.com>
	<151899307518.12376.3557657658351863552@sif>
Date: Fri, 23 Feb 2018 18:21:45 +0100
In-Reply-To: <151899307518.12376.3557657658351863552@sif> (Michael Roth's
	message of "Sun, 18 Feb 2018 16:31:15 -0600")
Message-ID: <87a7vzliza.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 09/29] qapi-gen: Convert from getopt to
 argparse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> Quoting Markus Armbruster (2018-02-11 03:35:47)
>> argparse is nicer to use than getopt, and gives us --help almost for
>> free.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi-gen.py    | 48 ++++++++++++++++++++++++++++++------------------
>>  scripts/qapi/common.py | 43 -------------------------------------------
>>  2 files changed, 30 insertions(+), 61 deletions(-)
>> 
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 2100ca1145..e5be484e3e 100755
>> --- a/scripts/qapi-gen.py
>> +++ b/scripts/qapi-gen.py
>> @@ -4,8 +4,11 @@
>>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>>  # See the COPYING file in the top-level directory.
>> 
>> +from __future__ import print_function
>> +import argparse
>> +import re
>>  import sys
>> -from qapi.common import parse_command_line, QAPISchema
>> +from qapi.common import QAPISchema
>>  from qapi.types import gen_types
>>  from qapi.visit import gen_visit
>>  from qapi.commands import gen_commands
>> @@ -15,26 +18,35 @@ from qapi.doc import gen_doc
>> 
>> 
>>  def main(argv):
>> -    (input_file, output_dir, prefix, opts) = \
>> -        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
>> +    parser = argparse.ArgumentParser(
>> +        description='Generate code from a QAPI schema')
>> +    parser.add_argument('-b', '--builtins', action='store_true',
>> +                        help="generate code for built-in types")
>> +    parser.add_argument('-o', '--output_dir', action='store', default='',
>
> Was the change from --output-dir to --output_dir intentional? The former
> seems more consistent.

Editing accident, good catch!
