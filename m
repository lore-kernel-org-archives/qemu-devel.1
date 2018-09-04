Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxFhV-0000AU-Qr
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 14:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxFhS-0000X6-KM
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 14:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxFhS-0000WG-BT
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 14:05:14 -0400
Date: Tue, 4 Sep 2018 20:05:10 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180904180510.gigbzwjfiu2fs2ne@kamzik.brq.redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-3-git-send-email-wei@redhat.com>
	<20180903112639.hnuprihktvifieuz@kamzik.brq.redhat.com>
	<2128164405.32860913.1536080671057.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2128164405.32860913.1536080671057.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 2/4] tests/migration: Support cross
 compilation in generating boot header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wehuang@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter maydell <peter.maydell@linaro.org>, quintela@redhat.com, dgilbert@redhat.com

On Tue, Sep 04, 2018 at 01:04:31PM -0400, Wei Huang wrote:
> > > +parse-cross-prefix = $(subst gcc,,$(patsubst cc,gcc,$(patsubst
> > > CROSS_CC_GUEST="%",%,$(shell grep "CROSS_CC_GUEST="
> > > $(SRC_PATH)/$(1)-softmmu/config-target.mak))))
> > > +gen-cross-prefix = $(patsubst %-,CROSS_PREFIX=%-,$(call
> > > parse-cross-prefix,$(1)))
> > >  
> > > -x86.bootsect: x86.boot
> > > -	dd if=$< of=$@ bs=256 count=2 skip=124
> > > +.PHONY: all $(TARGET_LIST)
> > >  
> > > -x86.boot: x86.o
> > > -	$(CROSS_PREFIX)objcopy -O binary $< $@
> > > +all: $(TARGET_LIST)
> > >  
> > > -x86.o: x86-a-b-bootblock.S
> > > -	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
> > > +$(TARGET_LIST):
> > > +	$(MAKE) -C $@ $(call gen-cross-prefix,$@)
> > >  
> > >  clean:
> > > -	@rm -rf *.boot *.o *.bootsect
> > > +	for target in $(TARGET_LIST); do \
> > > +		$(MAKE) -C $$target clean; \
> > > +	done
> > 
> > The above seems overly complicated. Does the following work?
> > 
> > $(TARGET_LIST): CROSS_PREFIX=$(CROSS_CC_GUEST)
> > $(TARGET_LIST):
> > 	$(MAKE) -C $@
> 
> No, it doen't work for different reasons.
> 
> First, to have CROSS_CC_GUEST defined, we normally would use "-include" to include config-target.mak file. But the end result is, the CROSS_CC_GUEST only has the same definition for both architectures (due to make command's multi-iteration processing and include is processed first). Secondly, CROSS_CC_GUEST needs to be polished because it can be: i) not defined; ii) "cc" without prefix; or iii) used-define value. We can't use it directly.
>

OK. Since I don't have any better suggestions. Then this is good
enough for me.

Thanks,
drew
