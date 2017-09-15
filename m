Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dss9Y-0003rQ-B4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dss9T-00020r-UF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dss9T-0001yt-K3
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:03:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0701A883C4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:03:28 +0000 (UTC)
Received: from nial.brq.redhat.com (unknown [10.43.2.209])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDC17B5AC
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:03:27 +0000 (UTC)
Date: Fri, 15 Sep 2017 17:03:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170915170326.5278d578@nial.brq.redhat.com>
In-Reply-To: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] generalize parsing of cpu_model
 (x86/arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Wed, 13 Sep 2017 18:04:52 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> Changelog since v1:
>  * fix merge conflicts with ignore_memory_transaction_failures
>  * fix couple merge conflicts where SoC type string where replaced by type macro
>  * keep plain prefix string in: strncmp(cpu_type, "pxa27", 5)
>  * s/"%s" ARM_CPU_TYPE_SUFFIX/ARM_CPU_TYPE_NAME("%s")/
>  * drop not needed assert
>  * instead of checking error/reporting/exiting explicitly
>    use error_fatal which will do all of it for us
>  * squash in "cpu: rename cpu_parse_features() to cpu_parse_cpu_model()"
> 
> 
> Issue 1:                                                                         
> Some callers call CPUClass->parse_features manually to convert                   
> '-cpu cpufoo,featurestr' string to cpu type and featurestr                       
> into a set of global properties and then do controlled                           
> cpu creation with setting properties and completing it with realize.             
> That's a lot of code duplication as they all are practically                     
> reimplement the same parsing logic.                                              
>                                                                                  
> Some use cpu_generic_init() instead which does the same parsing                  
> along with creation/realizing cpu within one wrapper.                            
>                                                                                  
> And some trying to switch to controlled cpu creation,                            
> implement object_new()/set properties/realize steps                              
> but forget feature parsing logic witch leads to 'bugs'                           
> commit (00909b585 hw/arm/integratorcp: Support specifying features via -cpu)     
>                                                                                  
> Issue 2:                                                                         
> Default cpu model selection logic is spread over  all board's                    
> machine_init() fuctions but it's basicallyi hardcodes default                    
> cpu model string in init function.                                               
>                                                                                  
>  if (!cpu_model) {                                                               
>      cpu_model = "some cpu model string";                                        
>  }                                                                               
>                                                                                  
> and written in different ways.                                                   
> it forces machine_init callbacks to parse cpu_model string                       
> either by using cpu_generic_init() or by manually calling                        
> cpu_class_by_name()/CPUClass::parse_features to perform                          
> name to cpu type translation.
> 
> This series moves -cpu option parsing to generic machine code                    
> that removes some of code duplication and makes cpus creation                    
> process more generic/simple:                                                            
>                                                                                  
>  * unify default (fallback) cpu type handling by replacing                       
>    hardcoded cpu_model strings with cpu type directly in                         
>                                                                                  
>    machine_foo_class_init() {                                                    
>        MachineClass::default_cpu_type = BOARD_DEFAULT_CPU_TYPE                   
>    }                                                                             
>                                                                                  
>    which allows to generalize move cpu model parsing instead of                  
>    parsing it in each board.                                                     
>                                                                                  
>  * make generic machine vl.c parse cpu_model into properties/cpu_type            
>    and let boards use cpu_type without any cpu_model prasing.                    
>    Generic parsing will kick in only if board advertises its support             
>    by setting MachineClass::default_cpu_type to a cpu type.                      
>                                                                                  
> PS:                                                                              
> I intend make tree-wide conversion but as one series it's too many patches,       
> so I'm splitting out it into an intial series that implements generic            
> part and several patchsets that will do per target conversion.                   
>                                                                                  
> As part of initial series x86 and ARM targets conversion is included             
> to showcase generalization usage. Per target conversions are done
> as 1 patch per target, it might be too much for targets that have lots
> of boards (ARM) so let me know if you'd like to split it on per board
> basis (then I'll respin it as separate series on top of generic patches)
> 
> github tree for testing:
> https://github.com/imammedo/qemu.git default_machine_cpu_type_PC_ARM_v2
> 
Hi Eduardo,

Could you merge it via machine tree?
