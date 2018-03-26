Received: from eggs.gnu.org ([2001:4830:134:3::10]:33654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0R3k-0002eK-Po
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0R3g-0007k8-PU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:17:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0R3g-0007jm-L4
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:17:04 -0400
References: <20180326111857.26146-1-otubo@redhat.com>
	<773067e7-21e6-351b-16d4-4d4558f68825@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fb61d6b-820a-5de1-4879-1f34f736d91b@redhat.com>
Date: Mon, 26 Mar 2018 14:16:54 +0200
MIME-Version: 1.0
In-Reply-To: <773067e7-21e6-351b-16d4-4d4558f68825@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mjt@tls.msk.ru, agraf@suse.de, ehabkost@redhat.com

On 26/03/2018 14:14, Thomas Huth wrote:
>> +    object_ref(OBJECT(dev));
>> +    object_property_set_bool(OBJECT(dev), false, "realized", &err);
>> +    if (err) {
>> +        error_reportf_err(err, "Clean up of device %s failed: ",
>> +                          object_get_typename(OBJECT(dev)));
>> +        exit(1);
>> +    }
>> +    object_unref(OBJECT(dev));
>> +}
> 
> I'm not a qdev expert, but I wonder whether we need the full object_ref
> + unref dance here? If not, you could get rid of this function and
> simply do the object_property_set_bool(OBJECT(dev), false, "realized",
> &error_fatal) twice in i8257_dma_init() instead.

No, however we do need an object_unparent call.

Paolo
