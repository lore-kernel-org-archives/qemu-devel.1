Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp71v-0005FY-Gc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp71q-0000cw-IN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:12:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36872 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fp71q-0000cU-DK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 03:12:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-29-armbru@redhat.com>
	<34547af9-dc93-687f-5a23-901fa8ebfaef@redhat.com>
Date: Mon, 13 Aug 2018 09:12:34 +0200
In-Reply-To: <34547af9-dc93-687f-5a23-901fa8ebfaef@redhat.com> (Paolo
	Bonzini's message of "Sun, 12 Aug 2018 11:52:21 +0200")
Message-ID: <878t5abuzh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 28/56] json: Fix \uXXXX for surrogate pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/08/2018 14:03, Markus Armbruster wrote:
>> +                if (cp >= 0xD800 && cp <= 0xDBFF && !leading_surrogate
>> +                    && ptr[1] == '\\' && ptr[2] == 'u') {
>> +                    ptr += 2;
>> +                    leading_surrogate = cp;
>> +                    goto hex;
>> +                }
>> +                if (cp >= 0xDC00 && cp <= 0xDFFF && leading_surrogate) {
>> +                    cp &= 0x3FF;
>> +                    cp |= (leading_surrogate & 0x3FF) << 10;
>> +                    cp += 0x010000;
>> +                }
>> +
>
> The leading surrogate is discarded for \uD800\uCAFE, I think.  Is this
> desired?

Certainly not.  I'll fix it.  Thanks!
