Received: from eggs.gnu.org ([2001:4830:134:3::10]:41114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dcWjM-0001IO-Lb
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 08:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dcWjJ-0000si-GW
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 08:57:00 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dcWjJ-0000ry-CA
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 08:56:57 -0400
Received: by mail-io0-f176.google.com with SMTP id o9so7921514iod.1
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 05:56:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170801105052.GA3108@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-3-apahim@redhat.com>
	<20170801100925.GF13521@stefanha-x1.localdomain>
	<20170801105052.GA3108@localhost.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 1 Aug 2017 14:56:55 +0200
Message-ID: <CALAZnb0kbXYFiyg6EYUDe_zjph7YxtLCyw67uvnGr0P9Hj31+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/7] qemu.py: fix is_running() return
 before first launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Tue, Aug 1, 2017 at 12:50 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Aug 01, 2017 at 11:09:25AM +0100, Stefan Hajnoczi wrote:
>> On Mon, Jul 31, 2017 at 10:51:05AM +0200, Amador Pahim wrote:
>> > is_running() returns None when called before the first time we
>> > call launch():
>> >
>> >     >>> import qemu
>> >     >>> vm = qemu.QEMUMachine('qemu-system-x86_64')
>> >     >>> vm.is_running()
>> >     >>>
>> >
>> > It should retunt False instead. This patch fixes that.
>>
>> s/retunt/return/
>>

Ack

>> >
>> > Signed-off-by: Amador Pahim <apahim@redhat.com>
>> > ---
>> >  scripts/qemu.py | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/qemu.py b/scripts/qemu.py
>> > index 2f1984c93c..77565eb092 100644
>> > --- a/scripts/qemu.py
>> > +++ b/scripts/qemu.py
>> > @@ -86,7 +86,7 @@ class QEMUMachine(object):
>> >              raise
>> >
>> >      def is_running(self):
>> > -        return self._popen and (self._popen.poll() is None)
>> > +        return self._popen is not None and (self._popen.poll() is None)
>>
>> The parentheses are inconsistent:
>>
>>   return (self._popen is not None) and (self._popen.poll() is None)

Parentheses are not needed here. I can remove the other one, if you want.

>>
>> An alternative:
>>
>>   return bool(self._popen and self._popen.poll())
>
> is_running() should be True only if self._popen.poll() is None
> (and not if it's 0), so the "self._popen.poll() is None" part is
> necessary.

+1

>
>
> --
> Eduardo
