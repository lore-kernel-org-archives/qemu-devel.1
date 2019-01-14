Received: from eggs.gnu.org ([209.51.188.92]:38565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj3xl-0002zc-Gp
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj3xk-0003Kj-Kv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:15:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj3xk-0003I7-Dc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:15:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so23283196wrw.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:15:34 -0800 (PST)
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<2d8dad3d-05a1-7c16-4640-1df9e2b82642@redhat.com>
	<baa8cae7-ad3c-aecb-7663-8bbe8beb739e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64e4a141-c9e9-5e69-d2f8-d4a2fb79713b@redhat.com>
Date: Mon, 14 Jan 2019 16:15:32 +0100
MIME-Version: 1.0
In-Reply-To: <baa8cae7-ad3c-aecb-7663-8bbe8beb739e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, berrange@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>

On 1/14/19 3:36 PM, Thomas Huth wrote:
> On 2019-01-14 15:31, Philippe Mathieu-Daudé wrote:
>> On 1/14/19 2:46 PM, Thomas Huth wrote:
>>> The header "scsi-lowlevel.h" of libiscsi 1.9.0 contains some bad
>>> "inline" prototype definitions which GCC refuses to compile in its
>>> gnu99 mode:
>>>
>>> In file included from block/iscsi.c:52:0:
>>> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
>>> ‘scsi_set_uint16’ declared but never defined [-Werror]
>>>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>>>              ^
>>> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
>>> ‘scsi_set_uint32’ declared but never defined [-Werror]
>>>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>>>              ^
>>>
>>> This has been fixed by upstream libiscsi in version 1.10.0 (see
>>> https://github.com/sahlberg/libiscsi/commit/7692027d6c11 ), but
>>> since we still want to support 1.9.0 for CentOS 7 / RHEL7, we
>>> have to work-around the issue by compiling with "-fgnu89-inline"
>>> in this case instead.
>>>
>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  configure | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index 2b9ba7d..aa80c17 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -4562,6 +4562,11 @@ if test "$libiscsi" != "no" ; then
>>>      libiscsi="yes"
>>>      libiscsi_cflags=$($pkg_config --cflags libiscsi)
>>>      libiscsi_libs=$($pkg_config --libs libiscsi)
>>> +    if $pkg_config --exact-version==1.9.0 libiscsi; then
>>
>> The first offending commit is d327ab09c which got included in 1.8.0, so
>> using "exact" is not correct.
> We require at least version 1.9.0, so the only version which can have
> this problem when compiling QEMU is 1.9.0.

Oh you are right, then:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
