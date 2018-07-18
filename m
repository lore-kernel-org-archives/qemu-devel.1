Received: from eggs.gnu.org ([2001:4830:134:3::10]:47165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffsHQ-0001o6-U6
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffsHM-0003kU-UN
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:38:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffsHM-0003k3-M7
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 15:38:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so5798480wrt.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:38:28 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-3-e.emanuelegiuseppe@gmail.com>
	<20180711144920.GN31228@stefanha-x1.localdomain>
	<887b55ee-4312-1fd8-a8cb-2152da33b981@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1222c915-3ece-5568-a708-9c29033fa47f@redhat.com>
Date: Wed, 18 Jul 2018 21:38:25 +0200
MIME-Version: 1.0
In-Reply-To: <887b55ee-4312-1fd8-a8cb-2152da33b981@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 11/07/2018 19:46, Emanuele wrote:
>>> +static void qpci(void)
>>> +{
>>> +    qos_node_create_interface("pci-bus");
>>> +}
>>> +
>>> +libqos_init(qpci);
>> Why does an interface need to be created?  The drivers declare which
>> interfaces they support?
>>
>> I don't think this can be used to detect typoes in the driver's
>> qos_node_produces() call since there is no explicit control over the
>> order in which libqos_init() functions are called.  So the driver may
>> call qos_node_produces() before the qos_node_create_interface() is
>> called?
> The interface is what is actually given to the test, so from there it
> can test the functions and fields regardless of which driver is actually
> implementing them.
> For example, sdhci-test uses the QSDHCI functions, and depending on the
> path the generic-sdhci or sdhci-pci functions will be used.

I think Stefan is right, if you adjust qos_node_create_interface so that
it is idempotent(*), you can make it static and call it from
qos_node_produces and qos_node_consumes.

(*) that is, fail like now if the node exists and is not an interface;
    but, succeed if the node exists and is an interface.

Thanks,

Paolo
